class CreateCardNameLookup
  def initialize(json_file_path)
    @json_file_path = json_file_path
  end

  def call
    json_file = File.read(@json_file_path)
    data_hash = JSON.parse(json_file)

    lookup_hash = make_lookup_hash(data_hash)

    File.open("db/lookup.json", "w") do |file|
      file.write(lookup_hash.to_json)
    end
  end

  private

  def make_lookup_hash(hash)
    lookup_hash = {}

    hash.each_pair do |set, data|
      data["cards"].each do |card|
        actual_name = card["name"]
        sanitized_name = ActiveSupport::Inflector.transliterate(actual_name).downcase.gsub(/[^a-z0-9\s]/i, '')
        multiverse = card["multiverseid"]

        if !lookup_hash[sanitized_name] && multiverse && multiverse != 0
          lookup_hash[sanitized_name] = {"name" => actual_name, "multiverse_id" => multiverse}
        end
      end
    end

    lookup_hash
  end
end
