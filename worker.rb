# worker.rb
require 'drb/drb'

DRb.start_service
queue = DRbObject.new_with_uri('druby://localhost:9999')
server = DRbObject.new_with_uri('druby://localhost:6666')

myName = server.register
puts myName

class MyBubble
	# http://stackoverflow.com/a/14394603
	def sort list
		return list if list.size <= 1 # already sorted
	  swapped = true
	  while swapped do
	    swapped = false
	    0.upto(list.size-2) do |i|
	      if list[i] > list[i+1]
	        list[i], list[i+1] = list[i+1], list[i] # swap values
	        swapped = true
	      end
	    end
	  end

	  list
	end
end

bubble = MyBubble.new
loop do
  data = queue.pop

  # Process the data
  puts "Receiving job"
  puts "Processing #{data.count} values"
  sorted = bubble.sort data
  server.print_sequence sorted, myName
  puts "Processed"
end