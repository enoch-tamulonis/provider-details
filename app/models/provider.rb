class Provider < ApplicationRecord
  serialize :data
  validates :npi_number, uniqueness: true, format: { with: /\A\d+\z/, message: "npi must be an integer" }
  validates :data, presence: true, length: { minimum: 2 }
  after_create_commit :broadcast_to_table
  after_update_commit :broadcast_to_table

  def self.create_from_npi(npi_number)
    provider_data = ProviderFinder.find(npi_number)
    create(data: provider_data, npi_number: provider_data.try("number"))
  end

  def full_name
    [first_name, last_name].compact.join(" ")
  end


  def first_name
    basic_data.first_name || basic_data.authorized_official_first_name
  end

  def last_name
    basic_data.last_name || basic_data.authorized_official_last_name
  end

  def organization_name
    basic_data.organization_name
  end

  def organization?
    npi_type.ends_with?("2")
  end

  def primary_address
    address_for_purpose("location")
  end

  def mailing_address
    address_for_purpose("mailing")
  end

  def taxonomies
    struct_data.taxonomies.map { |taxonomy| OpenStruct.new(taxonomy) }
  end

  def primary_taxonomy
    taxonomy = taxonomies.filter { |taxonomy| taxonomy.primary == true }.first
    OpenStruct.new(taxonomy)
  end

  def endpoints
    struct_data.endpoints
  end

  def npi_type
    struct_data.enumeration_type
  end

  def certification_date
    Date.parse(basic_data.certification_date)
  end

  def basic_data
    OpenStruct.new(struct_data.basic)
  end

  def struct_data
    OpenStruct.new(data)
  end

private
  def address_for_purpose(purpose)
    address_data = struct_data.addresses.filter { |address| address["address_purpose"].downcase == "mailing" }.first
    [address_data["address_1"], address_data.try("address_2"), address_data["city"], address_data["state"], address_data["country_code"]].compact.join(", ")
  end

  def broadcast_to_table
    broadcast_prepend_later_to("providers",
      target: "providers-table-body",
      partial: "providers/provider_row",
      locals: { provider: self })
  end
end
