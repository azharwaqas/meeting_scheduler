require 'time'
require 'rspec/autorun'

class MeetingScheduler
	
	
	def check_for_off_site_on_site_meeting(data)
		@values = data.map{|x| x[:type]}
		if @values.include?(:onsite) && @values.include?(:offsite)
			return true
		else
			return false
		end
	end
	
	def check_for_extend_start_past_offsite(data)
		@values = data.map{|x| x[:type]}
		if @values.include?(:onsite)
			return false
		else
			return true
		end
	end
	
	def set_meeting_data(scheduler, meeting, start_time, end_time)
		@meeting_end_time = start_time + (meeting[:duration].to_f * 3600)
		if @meeting_end_time <= end_time
			scheduler << "#{start_time.strftime("%I:%M %p")}" + " - " + "#{@meeting_end_time.strftime("%I:%M %p")}" + " "+  "#{meeting[:name]}"
		end
	end
	
	
	def parse_meeting(data, on_site)
		@start_time = Time.parse("9:00:00")
		@end_time = Time.parse("17:00:00")
		off_site = false
		@scheduler = []
		
		if on_site
			data.each do |meeting|
				if  @start_time < @end_time
					if meeting[:type] == :offsite
						@start_time = @start_time + 1800 if off_site == false
						set_meeting_data(@scheduler, meeting, @start_time, @end_time)
						@start_time = @meeting_end_time + 1800
						off_site = true
					else
						set_meeting_data(@scheduler, meeting, @start_time, @end_time)
						@start_time = @meeting_end_time
						off_site = false
					end
				end
			end
		else
			data.each do |meeting|
				if  @start_time < @end_time
					set_meeting_data(@scheduler, meeting, @start_time, @end_time)
					@start_time = @meeting_end_time + 1800
				end
			end
		end

		if data.count == @scheduler.count
			puts "Yes, can fit. One possible solution would be:"
			@scheduler.map {|schedule| puts schedule}
			return true
		else
			puts "No, can’t fit!"
			return false
		end
	end
	

	def meet(data)
		if check_for_off_site_on_site_meeting(data)
			on_site = true
			data = data.partition { |element| element[:type].match /^onsite$/ }.flatten
			parse_meeting(data, on_site)
		elsif check_for_extend_start_past_offsite(data)
			on_site = false
			parse_meeting(data, on_site)
		else
			on_site = true
			parse_meeting(data, on_site)
		end
	end
	
	
end

data = [
	{ name: "Meeting 1", duration: 3, type: :onsite },
	{ name: "Meeting 2", duration: 2, type: :offsite },
	{ name: "Meeting 3", duration: 1, type: :offsite },
	{ name: "Meeting 4", duration: 0.5, type: :onsite }
	]
	
data1 = 
[
{ name: "Meeting 1", duration: 1.5, type: :onsite },
{ name: "Meeting 2", duration: 2, type: :offsite },
{ name: "Meeting 3", duration: 1, type: :onsite },
{ name: "Meeting 4", duration: 1, type: :offsite },
{ name: "Meeting 5", duration: 1, type: :offsite }
]

data2 =
[
{ name: "Meeting 1", duration: 4, type: :offsite },
{ name: "Meeting 2", duration: 4, type: :offsite }
]

data3 = 
[
{ name: "Meeting 1", duration: 0.5, type: :offsite },
{ name: "Meeting 2", duration: 0.5, type: :onsite },
{ name: "Meeting 3", duration: 2.5, type: :offsite },
{ name: "Meeting 4", duration: 3, type: :onsite }
]

data4 = [
{ name: "Meeting 1", duration: 4, type: :offsite },
{ name: "Meeting 2", duration: 3.5, type: :offsite }
]
	

@meeting = MeetingScheduler.new

@meet = @meeting.meet(data)



describe MeetingScheduler do
  it "it should return true" do
    @meeting = MeetingScheduler.new
    expect(@meeting.meet(data)).to eq(true) # first data set in document
    expect(@meeting.meet(data1)).to eq(true) # second data set in document
    expect(@meeting.meet(data3)).to eq(true) # fourth data set in document
    expect(@meeting.meet(data4)).to eq(true) #additonal test case
  end
  
  it "it should return false" do
  	@meeting = MeetingScheduler.new
  	expect(@meeting.meet(data2)).to eq(false) # third data set in document
  end
end






#schedule_meeting(data)
