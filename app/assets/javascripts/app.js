var urlShortener = angular.module("urlShortener", []);
urlShortener.controller("MainCtrl", ["$scope", "$http", "$location", function ($scope, $http, $location) {
	$scope.backgroundImg = getABackgroundImg();
	$scope.getShortenedUrl = function(url) {
		return $http.post('/shortener/shorten', {'url': url}).then(function(response) {
			$scope.shortened_url = response.data.shortened_url;
			$scope.click_count = response.data.click_count;
			return;
		});
	};
	$scope.visitUrl = function(url) {
		return $http.get('/shortener/visit?url=' + url).then(function(response) {
			return;
		});
	};
}]);

function getABackgroundImg() {
	return "background/" + getRandomIntInclusive(1, 17) + ".png";
}

function getRandomIntInclusive(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}