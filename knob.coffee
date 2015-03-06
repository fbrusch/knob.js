app = angular.module 'knob', []

app.controller 'knobCtrl', ($scope) ->
    $scope.value = 45 


app.directive 'knob', ->
    restrict: 'E'
    scope:
        pos: "=?"
        max: "@?"
        min: "@?"
        height: "@?"
        width: "@?"
        color: "@?"
    template: require('fs').readFileSync __dirname+'/template.html', 'utf-8'

    controller: ($scope, $document) ->
        # defaults
        $scope.color = $scope.color || "black"
        $scope.max = $scope.max || "100"
        $scope.min = $scope.min || "0"
        $scope.pos = $scope.pos || 0
        $scope.height = $scope.pos || "100px"
        $scope.width = $scope.pos || "100px"

        $scope.normalise = (v) -> 
            (v-$scope.min)/($scope.max-$scope.min)*360

        $scope.mousedown = (event)->
            event.preventDefault()
            startPos = $scope.pos
            y = event.y

            inBounds = (v) -> v <= $scope.max and v >= $scope.min

            mouseGetXY = (e) ->
                if inBounds (startPos + e.y-y) 
                    $scope.pos = startPos + e.y-y
                    $scope.$apply()

            $document[0].addEventListener 'mousemove', mouseGetXY
            $document[0].addEventListener 'mouseup', -> 
                $document[0].removeEventListener 'mousemove', mouseGetXY
