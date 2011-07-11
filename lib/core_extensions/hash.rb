class Hash
	# converts a Hash to a key value pair for use in a querystring (qs is short for querystring)
	#   Also, it uses Rack::Utils to escape the strings
	#
	#		{ :id => 22, :me => 'you whore bag' }.to_qs
	#
	# yields
	#
	#		id=22&me=you+whore+bag
	#
  def to_qs
    collect do |key, value|
      "#{ CGI.escape(key.to_s) }=#{ CGI.escape(value.to_s) }"
    end.sort * '&'
  end
  
	# converts a Hash into an HTML attribute where the key is the attribute and the value is the value.
	#		{ :id => 'two', :class => 'me' }.to_attr
	#	yields
	#		id="two" class="me"
	#
	#	Really handy for generating markup
  def to_attr
    collect do |key, value|
      if value.is_a? Hash
        value.collect do |k, v|
          "#{key}-#{k}='#{v}'"
        end
      else
        value.nil? ? key.to_s : "#{key}='#{value}'"
      end
    end.join(' ').chomp
  end
end