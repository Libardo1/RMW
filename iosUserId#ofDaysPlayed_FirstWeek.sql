#All ios user id`s and the # of days they played in the first week!
set
	@beg_reg_date = '2016-10-01',
    @end_reg_date = '2016-12-31'
;

Select 
	weekPlayers.userId,
    weekPlayers.dl as '# of days played'
From
(
select
				distinct v_user_data.id as 'userId',			
				count(distinct date(listenDate)) as 'dl'
			from
				v_user_data
			left join
				sgj_rmr_play_log
			on
				sgj_rmr_play_log.user_id = v_user_data.id
			where
				registerDate between @beg_reg_date and @end_reg_date
			and
				(listenDate between date(registerDate) and DATE_ADD(date(registerDate),INTERVAL 7 DAY) or listenDate is NULL)
			and
				cb_regsource = 'ios'
			group by
			v_user_data.id
) weekPlayers     