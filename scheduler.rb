require 'time'

data = [
{ name: "Meeting 1", duration: 3, type: :onsite },
{ name: "Meeting 2", duration: 2, type: :offsite },
{ name: "Meeting 3", duration: 1, type: :offsite },
{ name: "Meeting 4", duration: 0.5, type: :onsite }
]


def calculate_hours(data)
	
	off_site = false
	@hours = []
	data.each do |meeting|
		if meeting[:type] == :onsite
			@hours << meeting[:duration]
			off_site = false
		else
			if off_site == false
				@hours << meeting[:duration] + 1
				#puts @hours
				off_site = true
			else
				@hours << meeting[:duration] + 0.5
				off_site = true
			end
			
		end
	end
	return @hours.sum
end

def do_meetings(meetings)
	off_site = false
	start_time = Time.parse("9:00:00")
	end_time = Time.parse("5:00:00")
	meetings.each do |meeting|
		if meeting[:type] == :offsite
			if off_site == false
				start_time = start_time + 1800
				start_time, meeting_end_time = set_time(start_time, meeting)
				start_time = meeting_end_time + 1800
				off_site = true
			else
				start_time, meeting_end_time = set_time(start_time, meeting)
				start_time = meeting_end_time + 1800
				off_site = true
			end
		else
			start_time, meeting_end_time = set_time(start_time, meeting)
			start_time = meeting_end_time
			off_site = false
		end
	end
	
end

def schedule_meeting(data)

	if data.any?
		@possibilites = data.permutation.to_a
		@possibilites.each do |meeting_set|
			@hours = calculate_hours(meeting_set)
			if @hours <= 8.5|| (@hours == 8.5 &&  meeting_set.any? {|h| h[:type] == :offsite})
				if @hours >= 8
					meeting_set = meeting_set.partition { |element| element[:type].match /^onsite$/ }.flatten
				end
					puts "Yes, can fit. One possible solution would be:"
					do_meetings(meeting_set)
				 	return
			end
		end
		puts "No Cant't fit"
	else
		puts "No data available"
	end
	
end



def set_time(start_time, meeting)
	meeting_end_time = start_time + (meeting[:duration].to_f * 3600)
	puts "#{start_time.hour}:#{start_time.min}" + " - " + "#{meeting_end_time.hour}:#{meeting_end_time.min}" + " "+  "#{meeting[:name]}"
	return start_time, meeting_end_time
end






schedule_meeting(data)
