!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:14'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:19'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'HAW 5/11/2017 21:01:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'testing' stamp: 'ARM 5/14/2017 17:29:21'!
test06CanNotCreateCellOutsideXBounds

	self 
		should: [ GameOfLife withLiveCells: { 4@1 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = GameOfLife cellOutOfBounds).
		]! !

!GOLTest methodsFor: 'testing' stamp: 'ARM 5/14/2017 17:36:03'!
test07CanNotCreateCellOutsideYBounds

	self 
		should: [ GameOfLife withLiveCells: { 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: GameOfLife cellOutOfBounds ]! !

!GOLTest methodsFor: 'testing' stamp: 'ARM 5/14/2017 15:46:09'!
test08CanNotCreateTwoAliveCellsInTheSamePosition

	|gol|
	 
		gol :=  GameOfLife withLiveCells: { 1@1. 1@1 } withSize: 3@3.
		self assert: (gol populationCount = 1).
		! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'public' stamp: 'DIC 5/16/2017 01:20:32'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfAliveCells! !

!GameOfLife methodsFor: 'public' stamp: 'HAW 5/11/2017 21:05:39'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :aCell | self hasToSurvive: aCell ]) union:
		(self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ])! !

!GameOfLife methodsFor: 'public' stamp: 'ARM 5/14/2017 15:48:20'!
populationCount
	^aliveCells size.! !


!GameOfLife methodsFor: 'private' stamp: 'DIC 5/16/2017 00:44:41'!
deadCells
	
	| allCells deadCells|
	
	allCells _ Set new.
	0 to: size x do: [ :x |
		0 to: size y do: [ :y |
			allCells add: x@y
		]
	].
	deadCells := allCells difference: aliveCells.
	^deadCells! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'private' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !

!GameOfLife methodsFor: 'private' stamp: 'ARM 5/14/2017 17:32:02'!
signalCellOutOfBounds
	self error: self class cellOutOfBounds! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'error handling' stamp: 'ARM 5/14/2017 17:27:37'!
cellOutOfBounds
	^'Celda fuera de rango'! !


!GameOfLife class methodsFor: 'instance creation' stamp: 'DIC 5/16/2017 01:05:03'!
withLiveCells: aCollectionOfAliveCells withSize: aSize
	
	| liveCells |
	liveCells := Set new. 
	liveCells addAll: aCollectionOfAliveCells.
	(liveCells allSatisfy: [:aCell | aCell between: 0@0 and: aSize]) ifFalse: [ self error: self cellOutOfBounds ].
	^self new initializeWith: liveCells withSize: aSize ! !
