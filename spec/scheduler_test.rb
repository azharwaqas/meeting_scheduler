require_relative '../scheduler'
require 'time'
require 'rspec/autorun'

day1 =
[
	{ name: "Meeting 1", duration: 3, type: :onsite },
	{ name: "Meeting 2", duration: 2, type: :offsite },
	{ name: "Meeting 3", duration: 1, type: :offsite },
	{ name: "Meeting 4", duration: 0.5, type: :onsite }
]
	
day2 = 
[
	{ name: "Meeting 1", duration: 1.5, type: :onsite },
	{ name: "Meeting 2", duration: 2, type: :offsite },
	{ name: "Meeting 3", duration: 1, type: :onsite },
	{ name: "Meeting 4", duration: 1, type: :offsite },
	{ name: "Meeting 5", duration: 1, type: :offsite }
]

day3 =
[
	{ name: "Meeting 1", duration: 4, type: :offsite },
	{ name: "Meeting 2", duration: 4, type: :offsite }
]

day4 = 
[
	{ name: "Meeting 1", duration: 0.5, type: :offsite },
	{ name: "Meeting 2", duration: 0.5, type: :onsite },
	{ name: "Meeting 3", duration: 2.5, type: :offsite },
	{ name: "Meeting 4", duration: 3, type: :onsite }
]

day5 = [
	{ name: "Meeting 1", duration: 4, type: :offsite },
	{ name: "Meeting 2", duration: 3.5, type: :offsite }
]

day6 = 
[
	{ name: "Meeting 1", duration: 1.5, type: :onsite },
	{ name: "Meeting 2", duration: 2.0, type: :onsite },
	{ name: "Meeting 3", duration: 2.5, type: :offsite },
	{ name: "Meeting 4", duration: 3, type: :onsite }
]

day7 = 
[
	{ name: "Meeting 1", duration: 1, type: :offsite },
	{ name: "Meeting 2", duration: 2.5, type: :onsite },
	{ name: "Meeting 3", duration: 0.5, type: :offsite },
	{ name: "Meeting 4", duration: 1, type: :onsite },
	{ name: "Meeting 5", duration: 1.5, type: :offsite }
]

@start_time = Time.parse("9:00")
@end_time = Time.parse("17:00")

describe MeetingScheduler do
  it "it should fit meeting day 1" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
    @meet_day_1 = @meeting.meet(day1)
    expect(@meet_day_1[0]).to eq("Yes, can fit. One possible solution would be:") # first data set in document
    expect(@meet_day_1[1]).to eq("09:00 AM - 12:00 PM Meeting 1")
    expect(@meet_day_1[2]).to eq("12:00 PM - 12:30 PM Meeting 4")
    expect(@meet_day_1[3]).to eq("01:00 PM - 03:00 PM Meeting 2")
    expect(@meet_day_1[4]).to eq("03:30 PM - 04:30 PM Meeting 3")
  end

  it "it should fit meeting day 2" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
    @meet_day_2 = @meeting.meet(day2)
    expect(@meet_day_2[0]).to eq("Yes, can fit. One possible solution would be:") # second data set in document
    expect(@meet_day_2[1]).to eq("09:00 AM - 10:30 AM Meeting 1")
    expect(@meet_day_2[2]).to eq("10:30 AM - 11:30 AM Meeting 3")
    expect(@meet_day_2[3]).to eq("12:00 PM - 02:00 PM Meeting 2")
    expect(@meet_day_2[4]).to eq("02:30 PM - 03:30 PM Meeting 4")
    expect(@meet_day_2[5]).to eq("04:00 PM - 05:00 PM Meeting 5")
  end

  it "it should fit meeting day 4" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
    @meet_day_4 = @meeting.meet(day4)
    expect(@meet_day_4[0]).to eq("Yes, can fit. One possible solution would be:") # Additional
    expect(@meet_day_4[1]).to eq("09:00 AM - 09:30 AM Meeting 2")
    expect(@meet_day_4[2]).to eq("09:30 AM - 12:30 PM Meeting 4")
    expect(@meet_day_4[3]).to eq("01:00 PM - 01:30 PM Meeting 1")
    expect(@meet_day_4[4]).to eq("02:00 PM - 04:30 PM Meeting 3")
  end

  it "it should fit meeting day 5" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
    @meet_day_5 = @meeting.meet(day5)
    expect(@meet_day_5[0]).to eq("Yes, can fit. One possible solution would be:") # Additional
    expect(@meet_day_5[1]).to eq("09:00 AM - 01:00 PM Meeting 1")
    expect(@meet_day_5[2]).to eq("01:30 PM - 05:00 PM Meeting 2")
  end

  it "it shouldn't fit meeting day 6" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
    @meet_day_6 = @meeting.meet(day6)
    expect(@meet_day_6.first).to eq("No, Can't fit!") # Additional
  end

  it "it should fit meeting day 7" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
    @meet_day_7 = @meeting.meet(day7)
    expect(@meet_day_7[0]).to eq("Yes, can fit. One possible solution would be:") # Additional
    expect(@meet_day_7[1]).to eq("09:00 AM - 11:30 AM Meeting 2")
    expect(@meet_day_7[2]).to eq("11:30 AM - 12:30 PM Meeting 4")
    expect(@meet_day_7[3]).to eq("01:00 PM - 02:00 PM Meeting 1")
    expect(@meet_day_7[4]).to eq("02:30 PM - 03:00 PM Meeting 3")
    expect(@meet_day_7[5]).to eq("03:30 PM - 05:00 PM Meeting 5")
  end

  it "it shouldn't fit meetings" do
    @meeting = MeetingScheduler.new(@start_time, @end_time)
  	@meet_day_3 = @meeting.meet(day3)
  	expect(@meet_day_3.first).to eq("No, Can't fit!") # third data set in document
  end
end 
