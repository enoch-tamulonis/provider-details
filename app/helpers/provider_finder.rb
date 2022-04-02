require 'net/http'

class ProviderFinder
  attr_reader :npi_number
  def initialize(npi_number)
    @npi_number = npi_number
  end

  def find
    result = fetch_results
  end

  def self.find(npi_number)
    instance = new npi_number
    instance.find
  end

private

  def api_url
    "https://npiregistry.cms.hhs.gov/api/?version=2.1"
  end

  def fetch_results
    uri = URI(api_url)
    params = URI.decode_www_form(uri.query) << ["number", npi_number]
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    if json.has_key?("results")
      results = json["results"][0]
    end
  end
end
