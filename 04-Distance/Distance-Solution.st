!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'distanceFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/29/2017 21:33:35'!
setUp
	distanceFactory := DistanceFactory new! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:08:23'!
test01CanCheckEqualityOnDistancesWithSameUnitOfDistance

	self assert: distanceFactory oneMeter = distanceFactory oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:02:31'!
test02CanAddDistancesWithSameUnitOfDistance

	self assert: distanceFactory oneMeter + distanceFactory oneMeter = distanceFactory twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:01:54'!
test03EqualityDoesNotDependOnUnitOfDistance

	self assert: distanceFactory oneMeter = distanceFactory oneHundredCentimeters .! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:05:51'!
test04NotAllDistancesAreEqual

	self deny: distanceFactory oneMeter = distanceFactory tenCentimeters .! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:10:28'!
test05CanAddDistancesWithDifferentUnitsOfDistance

	self assert: distanceFactory oneMeter + distanceFactory tenCentimeters = distanceFactory oneHundredAndTenCentimeters.
	self assert: distanceFactory oneKilometer + distanceFactory oneMeter = distanceFactory oneThousandAndOneMeters.
	self assert: distanceFactory oneCentimeter + distanceFactory oneMillimeter = distanceFactory elevenMillimeters
	! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:33:23'!
test06CanDivideDistancesByScalar

	self assert: distanceFactory oneMeter / 2 = distanceFactory halfMeter. ! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:33:31'!
test07CanSubstractDistances

	self assert: distanceFactory twoMeters - distanceFactory oneMeter = distanceFactory oneMeter.
	self assert: distanceFactory twoMeters - distanceFactory oneHundredCentimeters = distanceFactory oneThousandMillimeters. ! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:33:49'!
test08CanMultiplyDistancesByScalar

	self assert: distanceFactory oneMeter * 2 = distanceFactory twoMeters ! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:33:56'!
test09MultiplicationIsConmutativeWithDistanceAndScalar
	self assert: 2* distanceFactory oneMeter = distanceFactory twoMeters! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:34:20'!
test10DistancesCanBeGreaterThanOtherDistances

	self assert: distanceFactory twoMeters > distanceFactory oneMeter.
	self deny: distanceFactory oneMeter > distanceFactory twoMeters.
	self assert: distanceFactory tenKilometers > distanceFactory oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:37:00'!
test11DistancesCanBeLesserThanOtherDistances

	self assert: distanceFactory oneMeter < distanceFactory threeMeters.
	self deny: distanceFactory threeMeters < distanceFactory oneMeter.
	self assert: distanceFactory oneMeter < distanceFactory tenKilometers! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:37:03'!
test12DistancesCanBeGreaterOrEqualThenOtherDistances

	self assert: distanceFactory tenKilometers >= distanceFactory oneMeter.
	self assert: distanceFactory oneMeter >= distanceFactory oneMeter! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:38:35'!
test13DistancesCanBeLesserOrEqualThanOtherDistances

	self assert: distanceFactory oneMeter <= distanceFactory threeMeters.
	self assert: distanceFactory threeMeters <=distanceFactory threeMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:38:57'!
test14CanCreateRangeFromDistanceToAnotherByOneMetreStep

	self assert: (distanceFactory oneMeter to: distanceFactory threeMeters) = (OrderedCollection with: distanceFactory oneMeter with: distanceFactory twoMeters with: distanceFactory threeMeters)! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:39:01'!
test15CanCreateRangeFromDistanceToAnotherBySpecificDistanceStep
	
	self assert: (distanceFactory oneMeter to: distanceFactory twoThousandMillimeters by: distanceFactory twentyFiveCentimeters ) = (
		OrderedCollection 
			with: distanceFactory oneMeter
			with: distanceFactory oneHundredAndTwentyFiveCentimeters
			with: distanceFactory oneHundredAndFiftyCentimeters 
			with: distanceFactory oneHundredAndSeventyFiveCentimeters
			with: distanceFactory twoHundredCentimeters )! !

!DistanceTest methodsFor: 'testing' stamp: 'DIC 5/30/2017 00:40:48'!
test16CanIterateOverRangeOfDistancesAndDoSomething
	| aNewRange|
	
	aNewRange := OrderedCollection new.
	distanceFactory oneMeter to: distanceFactory threeMeters by: distanceFactory oneMeter do: [:aDistance | 
		aNewRange add: (aDistance + distanceFactory threeCentimeters)
	].
	self assert: aNewRange = (OrderedCollection 
									with: distanceFactory oneHundredAndThreeCentimeters 
									with: distanceFactory twoHundredAndThreeCentimeters 
									with: distanceFactory threeHundredAndThreeCentimeters ).! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'amount unitOfDistance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'arithmetic' stamp: 'DIC 5/28/2017 23:16:14'!
* aMultiplier
	^self class withAmount: amount * aMultiplier withUnitOfDistance: unitOfDistance copy.! !

!Distance methodsFor: 'arithmetic' stamp: 'DIC 5/28/2017 23:17:20'!
+ aDistance 
	| minUnitOfDistance|
	minUnitOfDistance := unitOfDistance compareWithAndReturnLower: aDistance unitOfDistance.
	^self class withAmount: (self convertTo: minUnitOfDistance) amount + (aDistance convertTo: minUnitOfDistance) amount withUnitOfDistance: minUnitOfDistance copy.! !

!Distance methodsFor: 'arithmetic' stamp: 'DIC 5/28/2017 23:17:00'!
- aDistance 
	| minUnitOfDistance|
	minUnitOfDistance := unitOfDistance compareWithAndReturnLower: aDistance unitOfDistance.
	^self class withAmount: (self convertTo: minUnitOfDistance) amount - (aDistance convertTo: minUnitOfDistance) amount withUnitOfDistance: minUnitOfDistance copy.! !

!Distance methodsFor: 'arithmetic' stamp: 'DIC 5/28/2017 23:16:33'!
/ aDivisor 
	^self class withAmount: amount/2 withUnitOfDistance: unitOfDistance copy.! !


!Distance methodsFor: 'private' stamp: 'DIC 5/28/2017 23:24:03'!
adaptToNumber: aNumber andSend: aSymbol 
	^self perform: aSymbol with: aNumber ! !

!Distance methodsFor: 'private' stamp: 'DIC 5/28/2017 20:12:50'!
amount
	^amount! !

!Distance methodsFor: 'private' stamp: 'DIC 5/28/2017 22:08:24'!
convertTo: aUnitOfDistance 
	^self class withAmount: amount / self unitOfDistance ratioToMetre * aUnitOfDistance ratioToMetre withUnitOfDistance: aUnitOfDistance! !

!Distance methodsFor: 'private' stamp: 'DIC 5/28/2017 20:12:30'!
unitOfDistance
	^unitOfDistance ! !


!Distance methodsFor: 'comparing' stamp: 'DIC 5/28/2017 23:30:31'!
< aDistance 
	^aDistance > self! !

!Distance methodsFor: 'comparing' stamp: 'DIC 5/28/2017 23:33:34'!
<= aDistance 
	^aDistance >= self! !

!Distance methodsFor: 'comparing' stamp: 'DIC 5/28/2017 22:18:18'!
= aDistance
	^(aDistance convertTo: unitOfDistance) amount = amount
	
	! !

!Distance methodsFor: 'comparing' stamp: 'DIC 5/28/2017 23:28:21'!
> aDistance 
	^(self convertTo: Metre new) amount > (aDistance convertTo: Metre new) amount! !

!Distance methodsFor: 'comparing' stamp: 'DIC 5/28/2017 23:32:43'!
>= aDistance 
	^(self convertTo: Metre new) amount >= (aDistance convertTo: Metre new) amount! !


!Distance methodsFor: 'initialization' stamp: 'DIC 5/28/2017 20:11:30'!
withAmount: anAmount withUnitOfDistance: aUnitOfDistance 
	amount := anAmount.
	unitOfDistance := aUnitOfDistance.
	^self! !


!Distance methodsFor: 'intervals' stamp: 'DIC 5/29/2017 00:34:42'!
to: aDistance 
	| aRangeOfDistances  steps acum oneMetre|
	oneMetre := self class withAmount: 1 withUnitOfDistance: Metre new.
	aRangeOfDistances := OrderedCollection new.
	steps := ((aDistance convertTo: Metre new) amount - (self convertTo: Metre new) amount) rounded + 1.
	acum := self.
	1 to: steps do: [:aStep |
		aRangeOfDistances add: acum.
		acum := acum + oneMetre 
		 ].
	^aRangeOfDistances ! !

!Distance methodsFor: 'intervals' stamp: 'DIC 5/29/2017 00:34:18'!
to: aDistance by: aStepDistance
	| aRangeOfDistances  steps acum|
	aRangeOfDistances := OrderedCollection new.
	steps := ((aDistance convertTo: aStepDistance unitOfDistance) amount - (self convertTo: aStepDistance unitOfDistance) amount / aStepDistance amount) rounded + 1.
	acum := self.
	1 to: steps do: [:aStep |
		aRangeOfDistances add: acum.
		acum := acum + aStepDistance 
		 ].
	^aRangeOfDistances ! !

!Distance methodsFor: 'intervals' stamp: 'DIC 5/29/2017 00:51:56'!
to: aDistance by: aStepDistance do: aMethod 
	(self to: aDistance by:aStepDistance) do: aMethod.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'creating' stamp: 'DIC 5/28/2017 20:12:00'!
withAmount: anAmount withUnitOfDistance: aUnitOfDistance 
	^self new withAmount:anAmount withUnitOfDistance:aUnitOfDistance! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:42:08'!
elevenMillimeters
	^Distance withAmount: 11 withUnitOfDistance: Millimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:42:30'!
halfMeter
	^Distance withAmount: 0.5 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:38:21'!
hundredAndTenCentimeters
	^Distance withAmount: 110 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:11:35'!
minusOneMeter
	^Distance withAmount: -1 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:11:58'!
oneCentimeter
	^Distance withAmount: 1 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'ARM 5/29/2017 22:38:42'!
oneHundredAndFiftyCentimeters
	^Distance withAmount: 150 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:48:40'!
oneHundredAndFiftyFiveCentimeters
	^Distance withAmount: 150 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:48:49'!
oneHundredAndSeventyFiveCentimeters
	^Distance withAmount: 175 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'ARM 5/29/2017 22:08:30'!
oneHundredAndTenCentimeters
	^Distance withAmount: 110 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:49:46'!
oneHundredAndThreeCentimeters
	^Distance withAmount: 103 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:48:20'!
oneHundredAndTwentyFiveCentimeters
	^Distance withAmount: 125 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:12:14'!
oneHundredCentimeters 
	^Distance withAmount: 100 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:38:44'!
oneKilometer
	^Distance withAmount: 1 withUnitOfDistance: Kilometre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:12:32'!
oneMeter
	^Distance withAmount: 1 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:41:57'!
oneMillimeter
	^Distance withAmount: 1 withUnitOfDistance: Millimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'ARM 5/29/2017 22:11:46'!
oneThousandAndOneMeters
	^Distance withAmount: 1001 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'ARM 5/29/2017 22:12:06'!
oneThousandMillimeters
	^Distance withAmount: 1000 withUnitOfDistance: Millimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:38:10'!
tenCentimeters
	^Distance withAmount: 10 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:46:32'!
tenKilometers
	^Distance withAmount: 10 withUnitOfDistance: Kilometre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:43:20'!
thousandAndOneMeters
	^Distance withAmount: 1001 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:43:11'!
thousandMillimeters
	^Distance withAmount: 1000 withUnitOfDistance: Millimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:49:24'!
threeCentimeters
	^Distance withAmount: 3 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:50:09'!
threeHundredAndThreeCentimeters
	^Distance withAmount: 303 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:46:50'!
threeMeters
	^Distance withAmount: 3 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:47:57'!
twentyFiveCentimeters
	^Distance withAmount: 25 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:50:00'!
twoHundredAndThreeCentimeters
	^Distance withAmount: 203 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:13:17'!
twoHundredCentimeters 
	^Distance withAmount: 200 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:13:33'!
twoMeters  
	^Distance withAmount: 2 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'ARM 5/29/2017 22:35:40'!
twoThousandMillimeters
	^Distance withAmount: 2000 withUnitOfDistance: Millimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:47:29'!
twoThousandMillmeters
	^Distance withAmount: 2000 withUnitOfDistance: Millimetre new.! !

!DistanceFactory methodsFor: 'instances' stamp: 'DIC 5/29/2017 21:16:38'!
zeroMeters
	^Distance withAmount: 0 withUnitOfDistance: Metre new.! !


!classDefinition: #UnitOfDistance category: #'Distance-Solution'!
Object subclass: #UnitOfDistance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!UnitOfDistance methodsFor: 'private' stamp: 'DIC 5/28/2017 22:53:29'!
compareWithAndReturnLower: aUnitOfDistance
	self ratioToMetre > aUnitOfDistance ratioToMetre ifTrue: [^self].
	^aUnitOfDistance
! !

!UnitOfDistance methodsFor: 'private' stamp: 'DIC 5/28/2017 22:53:43'!
ratioToMetre
	self subclassResponsibility 
! !


!classDefinition: #Centimetre category: #'Distance-Solution'!
UnitOfDistance subclass: #Centimetre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Centimetre methodsFor: 'private' stamp: 'DIC 5/28/2017 22:09:03'!
ratioToMetre
	^100! !


!classDefinition: #Kilometre category: #'Distance-Solution'!
UnitOfDistance subclass: #Kilometre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Kilometre methodsFor: 'private' stamp: 'DIC 5/28/2017 22:26:24'!
ratioToMetre
	^0.001! !


!classDefinition: #Metre category: #'Distance-Solution'!
UnitOfDistance subclass: #Metre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Metre methodsFor: 'private' stamp: 'DIC 5/28/2017 22:08:48'!
ratioToMetre
	^1! !


!classDefinition: #Millimetre category: #'Distance-Solution'!
UnitOfDistance subclass: #Millimetre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Millimetre methodsFor: 'private' stamp: 'DIC 5/28/2017 22:31:16'!
ratioToMetre
	^1000! !
