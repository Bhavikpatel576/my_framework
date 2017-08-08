
require_relative 'advice'

class App
	#The call method always returns an array, containing these 3 elements [1]:
	#status code-to_i, headers, Response Body
	def call(env)

		case env['REQUEST_PATH']
		when '/'
			# build a private method to do the word
			# template = File.read('./views/index.erb')
			# content = something = ERB.new(template)
    	[
    		'200', 
    		{'Content-Type' => 'text/html'},
    		# ['<h1>Hello World!</h1>']
    		#updated code in order to use .erb and call html file ./views/
    		response(status, headers) do 
                erb :index
            end
    	]
    when '/advice'
    	advice = Advice.new.generate
    	[	
    		'200',
    		{'Content-Type' => 'text/html'},
    		[erb(:advice, message: advice)]
    	]
    else
    	[
        '404',
        {"Content-Type" => 'text/plain', "Content-Length" => '13'},
        [erb(:not_found)]
      ]
    end
  end

	private

	# def erb(filename)
	# 	path = File.expand_path("../views/#{filename}.erb", _FILE_)
	# 	content = File.read(path)
	# 	ERB.new(content).result
	# end

	def erb(filename, local = {})
		b = binding
		message = local[:message]
		path = File.expand_path("../views/#{filename}.erb", _FILE_)
		content = File.read(path)
		ERB.new(content).result(b)
	end

end