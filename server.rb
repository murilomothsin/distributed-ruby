# server.rb
require 'drb/drb'

class MyApp
	@@worker_index = 0
	def register
		@@worker_index += 1
		"worker_#{@@worker_index}"
	end
  def print_sequence sequence, worker
  	puts worker
  end
end

Thread.new{
	puts "Getting Queue"
	DRb.start_service
	queue = DRbObject.new_with_uri('druby://localhost:9999')
	$i = 0;
	while $i < 10  do
		puts "Creating job"
	   queue.push (Array (1..50000)).shuffle
	   $i +=1
	end
	# loop do
	# 	queue.push (Array (1..1000000)).shuffle
	# end
}

puts "Creating Server service"
object = MyApp.new
DRb.start_service('druby://localhost:6666', object)
DRb.thread.join