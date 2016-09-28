var urlShortener = angular.module('urlShortener', ['ngclipboard']);
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
			if ($location.host() == "localhost") {
				console.log($location.host);
				$scope.shortenedUrl = $location.protocol() + "://" + $location.host() + ":" + $location.port() + "/" + response.data.shortened_url;
				$scope.hrefUrl = $location.protocol() + "://" + $scope.shortenedUrl;
			}
			else {
				$scope.shortenedUrl = $location.host() + "/" + response.data.shortened_url;
				$scope.hrefUrl = $location.protocol() + "://" + $scope.shortenedUrl;
			}
			$scope.title = response.data.title;
			$scope.clickCount = response.data.click_count;
			return;
		}, function (response) {
			$scope.requestError = true;
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