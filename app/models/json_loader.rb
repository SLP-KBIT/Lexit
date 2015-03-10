class JsonLoader
  def load(json)
    JSON.parse(json) if json.present?
  end

  def dump(hash)
    hash.to_json
  end
end
