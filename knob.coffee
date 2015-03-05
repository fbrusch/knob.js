app = angular.module 'knob', []

app.controller 'knobCtrl', ($scope) ->
    $scope.value = 45 

app.directive 'knob', ->
    restrict: 'E'
    scope:
        pos: "="
        max: "="
        min: "="
    template: """
        <p> {{pos}} </p>
        <svg width="100%" height="100%" viewBox="0 0 100 100"
            ng-mousedown="mousedown($event)">
            <circle cx="50" cy="50" r="45"
                    stroke-width="10"
                    stroke="black"
                    fill="white">
            </circle>
            <line x1="50" y1="50" x2="50" y2="17"
                  stroke-width="10"
                  stroke="black"
                  transform="rotate({{normalise(pos)}} 50 50)">
            </line>
        </svg>

    """
    controller: ($scope, $document) ->
        $scope.normalise = (v) -> 
            (v-$scope.min)/($scope.max-$scope.min)*360
        $scope.mousedown = (event)->
            startPos = $scope.pos
            console.log event
            x = event.x
            y = event.y
            inBounds = (v) -> v <= $scope.max and v >= $scope.min

            mouseGetXY = (e) ->
                if inBounds (startPos + e.y-y) 
                    $scope.pos = startPos + e.y-y
                    $scope.$apply()
            $document[0].addEventListener 'mousemove', mouseGetXY
            $document[0].addEventListener 'mouseup', -> 
                $document[0].removeEventListener 'mousemove', mouseGetXY
