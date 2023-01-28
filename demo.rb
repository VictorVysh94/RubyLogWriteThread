#Create "output" folder before execute!
require './lom'

logger = LogHandler.new("output",0.05,"demo",1,"%Y_%m_%d","csv")
logger.run_thread()
counter = 0
while 1
	$logArray.append(counter)
	counter=counter+1
	sleep 1
	puts counter
end
