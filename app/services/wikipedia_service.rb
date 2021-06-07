class WikipediaService
  require 'json'
  include HTTParty

  def self.fetch_id name
    id_result = HTTParty.get("https://en.wikipedia.org/w/api.php?action=query&prop=pageprops&format=json&origin=*&titles=#{name}").to_json
    @result = JSON.parse(id_result)
    id = @result["query"]["pages"].values.first["pageprops"]["wikibase_item"]
  end

  def self.fetch_languages_list id
    lang_list_result = HTTParty.get("https://www.wikidata.org/w/api.php?action=wbgetentities&format=json&origin=*&props=sitelinks&ids=#{id}").to_json
    result = JSON.parse(lang_list_result)
    langs_name =  result["entities"].values.first["sitelinks"].keys
  end

  def self.fetch_count locale, name
    words_result = HTTParty.get("http://#{locale}.wikipedia.org/w/api.php?format=json&origin=*&action=query&list=search&srwhat=nearmatch&srlimit=1&srsearch=#{name}").to_json
    @result = JSON.parse(words_result)
    title =  @result["query"]["search"].first["title"]
    count =  @result["query"]["search"].first["wordcount"]
    return {title: title, count: count}
  end

end