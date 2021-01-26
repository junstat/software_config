MILLIS_IN_DAY: 24 * 60 * 60 * 1000
MILLIS_IN_HOUR: 60 * 60 * 1000
MILLIS_IN_MINUTE: 60 * 1000
# MILLIS_IN_SECOND: 1000

countdowns: [
	label: "Saturday"
	time: "Jan 30, 2021 9:00 PM"
,
	label: "New Year's Eve"
	time: "Feb 11, 2021"
,
	label: "Birthday"
	time: "Aug 4, 2021"
,
	label: "2021 Q1"
	time: "Apr 1, 2021"
]

command: ""

refreshFrequency: 60000  # 1 min

style: """
	*
		margin 0
		padding 0

	#container
		position: fixed
		top: 10px
		right: 30px
		background rgba(#000, .5)
		padding 10px
		border-radius 5px

		color rgba(#fff, .9)
		font-family Helvetica Neue
	
	span
		padding 15px
		font-size 14pt
		font-weight bold

	ul
		list-style none

	li
		width 200px
		padding 10px

		&:not(:last-child)
			border-bottom solid 1px white

	thead
		font-size 8pt
		font-weight bold

		td
			width 60px

	tbody
		font-size 12pt

	td
		text-align center
"""

render: -> """
	<div id="container">
		<ul>
		</ul>
	</div>
"""

afterRender: ->
	for countdown in @countdowns
		countdown.millis = new Date(countdown.time).getTime()

update: (output, domEl) ->
	$countdownList = $(domEl).find("#container").find("ul")
	$countdownList.empty()

	now = new Date().getTime()

	# $root.html new Date
	# $root.html new Date @countdowns[1].time
	for countdown in @countdowns
		millisUntil = countdown.millis - now
		timeUntil = {}

		timeUntil.days = millisUntil // @MILLIS_IN_DAY
		millisUntil %= @MILLIS_IN_DAY

		timeUntil.hours = millisUntil // @MILLIS_IN_HOUR
		millisUntil %= @MILLIS_IN_HOUR

		timeUntil.minutes = millisUntil // @MILLIS_IN_MINUTE
		millisUntil %= @MILLIS_IN_MINUTE

		# timeUntil.seconds = millisUntil // @MILLIS_IN_SECOND
		# millisUntil %= @MILLIS_IN_SECOND

		$countdownList.append("""
			<li>
				<span>#{countdown.label}</span>
				<table>
					<thead>
						<tr>
							<td>DAYS</td>
							<td>HOURS</td>
							<td>MINUTES</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>#{timeUntil.days}</td>
							<td>#{timeUntil.hours}</td>
							<td>#{timeUntil.minutes}</td>
						</tr>
					</tbody>
				</table>
			</li>
		""")