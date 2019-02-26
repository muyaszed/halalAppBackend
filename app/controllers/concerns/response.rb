module Response
    def json_response(object, root=nil, serializer=nil, status = :ok)
      
      render json: object, status: status
      
    end
  end