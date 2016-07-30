var urlShortener = angular.module("urlShortener", []);
urlShortener.controller("MainCtrl", ["$scope", function ($scope) {
	$scope.test = "hello world";
	$scope.backgroundImg = getABackgroundImg();
}]);

function getABackgroundImg() {
	return "background/" + getRandomIntInclusive(1, 17) + ".png";
}

function getRandomIntInclusive(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}