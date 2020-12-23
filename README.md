There is a class name MeetingScheduler.
We have a public method Meet in it. Which checks data sets from some private methods are parse data According to that.
Private Method check_for_off_site_on_site_meeting, it checks for if data set contain offsite and onsite meeings then it returns true.
Private Method check_for_extend_start_past_offsite, it checks for if data set has only offiste meetings. It is for the case if we have back to back offsite meeting
and start and end time and extend past the day. For handle that case this method was designed.

Parse meeting method it takes some parameters of data set and array. It start from start of the day and adding time into it with duration of meeting and it parse the result
and append it on to the scheduler array, which we initiate it with class.
