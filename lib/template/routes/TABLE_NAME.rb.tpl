# encoding: UTF-8

get '%%PREFIX%%/%%TABLE_NAME%%.?:format?' do
  format_response(%%MODEL_NAME%%.all, (params[:format])? format_by_extensions(params[:format]): request.accept.first)
end

get '%%PREFIX%%/%%TABLE_NAME%%/:id.?:format?' do
  obj ||= %%MODEL_NAME%%.get(params[:id]) || halt(404)
  format_response(obj, (params[:format])? format_by_extensions(params[:format]): request.accept.first)
end

post '%%PREFIX%%/%%TABLE_NAME%%.?:format?' do
  is_raw = request.content_type.to_s.downcase.eql?('application/x-www-form-urlencoded')
  body = (is_raw)? request.POST() : JSON.parse(request.body.read)
  obj = %%MODEL_NAME%%.create(body)
  status 201
  format_response(obj, (params[:format])? format_by_extensions(params[:format]): request.accept.first)
end

put '%%PREFIX%%/%%TABLE_NAME%%/:id.?:format?' do
  is_raw = request.content_type.to_s.downcase.eql?('application/x-www-form-urlencoded')
  body = (is_raw)? request.POST() : JSON.parse(request.body.read)
  obj ||= %%MODEL_NAME%%.get(params[:id]) || halt(404)
  body.symbolize!
  obj.attributes = obj.attributes.merge(body)
  halt 500 unless obj.save!
  format_response(obj, (params[:format])? format_by_extensions(params[:format]): request.accept.first)
end

delete '%%PREFIX%%/%%TABLE_NAME%%/:id' do
  obj ||= %%MODEL_NAME%%.get(params[:id]) || halt(404)
  halt 500 unless obj.destroy
end
