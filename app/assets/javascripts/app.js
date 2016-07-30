var urlShortener = angular.module("urlShortener", []);
urlShortener.controller("MainCtrl", ["$scope", function ($scope) {
	$scope.test = "hello world";
}]);