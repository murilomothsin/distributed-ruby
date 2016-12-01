# producer.rb - or type this in an irb session
require 'drb/drb'

DRb.start_service
queue = DRbObject.new_with_uri('druby://localhost:9999')

# queue.push(42)
# sleep 5
# queue.push(99)
# sleep 5
# queue.push(100)
# sleep 5
# queue.push(2)
# sleep 5
# queue.push(25)
# sleep 25
# queue.push(40)
# sleep 2
# queue.push("Finnish")
i = 0
loop do
	queue.push(i+=1)
end