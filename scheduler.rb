require 'time'
class MeetingScheduler

	def initialize(start_time, end_time)
		@start_time = Time.parse("9:00")
		@end_time = Time.parse("17:00")
		@scheduler = []
	end

	def meet(data)
		if check_for_off_site_on_site_meeting(data)
			on_site = true
			data = data.partition { |element| element[:type].match /^onsite$/ }.flatten
			parse_meeting(data, on_site, @scheduler)
		elsif check_for_extend_start_past_offsite(data)
			on_site = false
			parse_meeting(data, on_site, @scheduler)
		else
			on_site = true
			parse_meeting(data, on_site, @scheduler)
		end
		return @scheduler
	end

	private

	def check_for_off_site_on_site_meeting(data)
		@values = data.map{|x| x[:type]}
		@values.include?(:onsite) && @values.include?(:offsite) ? true :  false
	end

	def check_for_extend_start_past_offsite(data)
		@values = data.map{|x| x[:type]}
		@values.include?(:onsite) ?  false :  true
	end

	def set_meeting_data(scheduler, meeting, start_time, end_time)
		@meeting_end_time = start_time + (meeting[:duration].to_f * 3600)
		scheduler << "#{start_time.strftime("%I:%M %p")}" + " - " + "#{@meeting_end_time.strftime("%I:%M %p")}" + " "+  "#{meeting[:name]}" if @meeting_end_time <= end_time
	end

	def parse_meeting(data, on_site, scheduler)
		off_site = false
		@scheduler = scheduler
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
			@scheduler.unshift("Yes, can fit. One possible solution would be:")
			@scheduler.map {|schedule| puts schedule}
			return @schudler
		else
			@scheduler.unshift("No, Can't fit!")
			puts @scheduler.first
		end
	end

end