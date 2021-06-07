class Api::V1::ArticlesController < Api::V1::BaseController

  def get_id
    wikibase_item = WikipediaService.fetch_id(params[:name])
    render :json => { success: true, data: {item_id: wikibase_item} }, status: 200
  end

  def get_langs_list
    langs_list = WikipediaService.fetch_languages_list(params[:id])
    render :json => { success: true, data: {langs_name: langs_list} }, status: 200
  end

  def words_count
    count_result = WikipediaService.fetch_count(params[:locale], params[:name])
    render :json => { success: true, data: count_result }, status: 200
  end

end