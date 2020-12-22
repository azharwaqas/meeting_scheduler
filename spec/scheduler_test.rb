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

describe MeetingScheduler do
  it "it should fit meeting day 1" do
    @meeting = MeetingScheduler.new()
    @meet_day_1 = @meeting.meet(day1)
    expect(@meet_day_1.first).to eq("Yes, can fit. One possible solution would be:") # first data set in document
  end

  it "it should fit meeting day 2" do
    @meeting = MeetingScheduler.new()
    @meet_day_2 = @meeting.meet(day2)
    expect(@meet_day_2.first).to eq("Yes, can fit. One possible solution would be:") # second data set in document
  end

  it "it should fit meeting day 4" do
    @meeting = MeetingScheduler.new()
    @meet_day_4 = @meeting.meet(day4)
    expect(@meet_day_4.first).to eq("Yes, can fit. One possible solution would be:") # Additional
  end

  it "it should fit meeting day 5" do
    @meeting = MeetingScheduler.new()
    @meet_day_5 = @meeting.meet(day5)
    expect(@meet_day_5.first).to eq("Yes, can fit. One possible solution would be:") # Additional
  end

  it "it shouldn't fit meeting day 6" do
    @meeting = MeetingScheduler.new()
    @meet_day_6 = @meeting.meet(day6)
    expect(@meet_day_6.first).to eq("No, Can't fit!") # Additional
  end

  it "it should fit meeting day 7" do
    @meeting = MeetingScheduler.new()
    @meet_day_7 = @meeting.meet(day7)
    expect(@meet_day_7.first).to eq("Yes, can fit. One possible solution would be:") # Additional
  end

  it "it shouldn't fit meetings" do
  	@meeting = MeetingScheduler.new()
  	@meet_day_3 = @meeting.meet(day3)
  	expect(@meet_day_3.first).to eq("No, Can't fit!") # third data set in document
  end
end 
