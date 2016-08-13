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
		$scope.copied = false;
		return $http.post('/shortener/shorten', {'url': url}).then(function(response) {
			$scope.shortened_url = $location.protocol() + "://" + $location.host() + ":" + $location.port() + "/" + response.data.shortened_url;
			$scope.title = response.data.title;
			$scope.click_count = response.data.click_count;
			return;
		}).finally(function() {
			$scope.loading = false;
		});
	};
	// $scope.visitUrl = function(url) {
	// 	$window.location.href = url;
	// };
}]);

function getABackgroundImg() {
	return "background/" + getRandomIntInclusive(1, 17) + ".png";
}

function getRandomIntInclusive(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}