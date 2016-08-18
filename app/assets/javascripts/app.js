var urlShortener = angular.module('urlShortener', ['ngclipboard'], function($compileProvider) {
	$compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|localhost):/);
});
urlShortener.config(['$locationProvider', function($locationProvider) {
	$locationProvider.html5Mode(true);
}]);
urlShortener.controller("MainCtrl", ["$scope", "$http", "$location", "$window", function ($scope, $http, $location, $window) {
	$scope.backgroundImg = getABackgroundImg();
	$scope.getShortenedUrl = function(url) {
		$scope.loading = true;
		$scope.requestError = false;
		$scope.copied = false;
		return $http.post('/shortener/shorten', {'url': url}).then(function (response) {
			$scope.shortenedUrl = $location.protocol() + "://" + $location.host() + ":" + $location.port() + "/" + response.data.shortened_url;
			$scope.title = response.data.title;
			$scope.clickCount = response.data.click_count;
			return;
		}, function (response) {
			$scope.requestError = true;
		}).finally(function() {
			$scope.loading = false;
		});
	};
}]);

function getABackgroundImg() {
	return "background/" + getRandomIntInclusive(1, 17) + ".png";
}

function getRandomIntInclusive(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}