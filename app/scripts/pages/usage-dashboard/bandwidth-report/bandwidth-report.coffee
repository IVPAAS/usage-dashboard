do ->

	module = angular.module 'KalturaUsageDashboard.usage-dashboard.bandwidth-report', ['classy']

	module.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider.state 'usage-dashboard.bandwidth',
				url: '/bandwidth'
				views:
					main:
						controller: 'BandwidthReportCtrl'
						templateUrl: 'app/scripts/pages/usage-dashboard/bandwidth-report/bandwidth-report.html'
				data:
					pageTitle: 'Bandwidth Report'
	]

	module.classy.controller
		name: 'BandwidthReportCtrl'
		inject: ['bandwidthReport', 'utils', '$filter']

		fetch: ->
			@_extractPayload()
			@_fetchData()

		_extractPayload: ->
			@payload = @utils.reports.extractPayload @$.dates

		_fetchData: ->
			@$.months = null
			@bandwidthReport.fetch(@payload).then (response) =>
				@$.months = _.extend response, dates: @$.dates
			, (response) =>
				console.log response