# Global variable logArray need to be filles with data using "append"
# Data will be writed after thread see "new data" in variable.
$logArray = Array.new

class LogHandler
	@folder_path
	@sleep_time
	@is_enabled
	@new_line
	
	@filename
	@set_time
	@time_format
	@file_type
	
	def initialize(folder_path,sleep_time=0.05,filename="",set_time=1,time_format="%Y_%m_%d",file_type="log",new_line=1)
		@folder_path = folder_path
		@sleep_time = sleep_time
		@filename = filename
		@set_time = set_time
		@time_format = time_format
		@file_type = file_type
		@new_line = new_line
	end
	def run_thread()
		@is_enabled = 1
		Thread.new {
			while @is_enabled
				if $logArray.size > 1
					begin
						file = File.open("#{@folder_path}\\#{get_filename}","a")
						if @new_line
							file.write("#{$logArray.pop}\n")
						else
							file.write("#{$logArray.pop}")
						end
						file.close()
					rescue =>exception
						puts "Error:#{exception}"
					end
				end
				sleep @sleep_time
			end
		}
	end
	def exit_thread()
		@is_enabled = 0
	end
	def get_filename()
		temp_filename = "#{@filename}"
		if @set_time
			temp_filename=temp_filename+"_#{Time.now.strftime("#{@time_format}")}"
		end
		temp_filename=temp_filename+".#{@file_type}"
		return temp_filename
	end
end