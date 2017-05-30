!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:41:29'!
test01OneMetreEqualsAnotherMetre
	| anotherOneMetre oneMetre |
	oneMetre := Distance withAmount:1  withUnitOfDistance: Metre new.
	anotherOneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	self assert: oneMetre = anotherOneMetre.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:42:30'!
test02OneMetrePlusOneMetreEqualsTwoMetres
	| twoMetres oneMetre |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	twoMetres := Distance withAmount: 2 withUnitOfDistance: Metre new.
	self assert: oneMetre + oneMetre = twoMetres.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:42:51'!
test03OneMetreEqualsHundredCentimetres
	| oneMetre hundredCentimetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	hundredCentimetres := Distance withAmount: 100 withUnitOfDistance: Centimetre new.
	self assert: oneMetre = hundredCentimetres.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:43:21'!
test04OneMetreNotEqualsTenCentimetres
	| oneMetre tenCentimetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	tenCentimetres := Distance withAmount: 10 withUnitOfDistance: Centimetre new.
	self deny: oneMetre = tenCentimetres.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:44:16'!
test05OneMetrePlusTenCentimetresEqualsHundredAndTenCentimetres
	| oneMetre tenCentimetres hundredAndTenCentimetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	tenCentimetres := Distance withAmount: 10 withUnitOfDistance: Centimetre new.
	hundredAndTenCentimetres := Distance withAmount: 110 withUnitOfDistance: Centimetre new.
	self assert: oneMetre + tenCentimetres = hundredAndTenCentimetres.! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:45:53'!
test06OneKilometrePlusOneMetreEqualsThousandAndOneMetres
	| oneKilometre oneMetre thousandAndOneMetres |
	oneKilometre := Distance withAmount: 1 withUnitOfDistance: Kilometre new.
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	thousandAndOneMetres := Distance withAmount: 1001 withUnitOfDistance: Metre new.
	self assert: oneKilometre + oneMetre = thousandAndOneMetres! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:46:24'!
test07OneCentimetrePlusOneMillimetresEqualsElevenMillimetres
	| oneCentimetre oneMillimetre elevenMillimetres |
	oneCentimetre := Distance withAmount: 1 withUnitOfDistance: Centimetre new.
	oneMillimetre := Distance withAmount: 1 withUnitOfDistance: Millimetre new.
	elevenMillimetres := Distance withAmount: 11 withUnitOfDistance: Millimetre new.
	self assert: oneCentimetre + oneMillimetre = elevenMillimetres ! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:35:03'!
test08OneMetreDividedByTwoEqualsHalfMetre
	| oneMetre halfMetre |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	halfMetre := Distance withAmount: 1/2 withUnitOfDistance: Metre new.
	self assert: oneMetre / 2 = halfMetre ! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:35:44'!
test09TwoMetresMinusHundredCentimetresEqualsThousandMillimetres
	| twoMetres hundredCentimetres thousandMillimetres |
	twoMetres := Distance withAmount: 2 withUnitOfDistance: Metre new.
	hundredCentimetres := Distance withAmount: 100 withUnitOfDistance: Centimetre new.
	thousandMillimetres := Distance withAmount: 1000 withUnitOfDistance: Millimetre new.
	self assert: twoMetres - hundredCentimetres = thousandMillimetres ! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:36:11'!
test10OneMetreMultipliedByTwoEqualsTwoMetres
	| oneMetre twoMetres|
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	twoMetres := Distance withAmount: 2 withUnitOfDistance: Metre new.
	self assert: oneMetre * 2 = twoMetres! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:37:26'!
test11TwoMultipliedByOneMetresEqualsTwoMetres
	| oneMetre twoMetres|
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	twoMetres := Distance withAmount: 2 withUnitOfDistance: Metre new.
	self assert: 2* oneMetre = twoMetres! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:38:11'!
test12TenKilometresGreaterThanOneMetre
	| tenKilometres oneMetre|
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	tenKilometres := Distance withAmount: 10 withUnitOfDistance: Kilometre new.
	self assert: tenKilometres > oneMetre ! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:41:07'!
test13OneMetreLesserThanThreeMetres
	| oneMetre threeMetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	threeMetres := Distance withAmount: 3 withUnitOfDistance: Metre new.
	self assert: oneMetre < threeMetres! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:39:27'!
test14TenKilometresGreaterOrEqualThanOneMetre
	| tenKilometres oneMetre|
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	tenKilometres := Distance withAmount: 10 withUnitOfDistance: Kilometre new.
	self assert: tenKilometres >= oneMetre.
	self assert: oneMetre >= oneMetre! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:40:58'!
test15OneMetreLesserOrEqualThanThreeMetres
	| oneMetre threeMetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	threeMetres := Distance withAmount: 3 withUnitOfDistance: Metre new.
	self assert: oneMetre <= threeMetres.
	self assert: threeMetres <= threeMetres! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:46:01'!
test16CanCreateRangeFromOneMetreToThreeMetresByOneMetreStep
	| oneMetre threeMetres twoMetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	twoMetres := Distance withAmount: 2 withUnitOfDistance: Metre new.
	threeMetres := Distance withAmount: 3 withUnitOfDistance: Metre new.
	self assert: (oneMetre to: threeMetres) = (OrderedCollection with: oneMetre with: twoMetres with:threeMetres)! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 00:30:45'!
test17CanCreateRangeFromOneMetreToTwoThousandMillimetresByTwentyFiveCentimetres
	| hundredAndFiftyCentimetres hundredAndSeventyFiveCentimetres hundredAndTwentyFiveCentimetres hundredCentimetres twoHundredCentimetres twoThousandMillimetres oneMetre twentyFiveCentimetres |
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	twoThousandMillimetres := Distance withAmount: 2000 withUnitOfDistance: Millimetre new.
	twentyFiveCentimetres := Distance withAmount: 25 withUnitOfDistance: Centimetre new.
	hundredCentimetres := Distance withAmount: 100 withUnitOfDistance: Centimetre new.
	hundredAndTwentyFiveCentimetres := Distance withAmount: 125 withUnitOfDistance: Centimetre new.
	hundredAndFiftyCentimetres := Distance withAmount: 150 withUnitOfDistance: Centimetre new.
	hundredAndSeventyFiveCentimetres := Distance withAmount: 175 withUnitOfDistance: Centimetre new.
	twoHundredCentimetres := Distance withAmount: 200 withUnitOfDistance: Centimetre new.
	
	self assert: (oneMetre to: twoThousandMillimetres by: twentyFiveCentimetres ) = (
		OrderedCollection 
			with: oneMetre
			with: hundredAndTwentyFiveCentimetres
			with: hundredAndFiftyCentimetres 
			with: hundredAndSeventyFiveCentimetres
			with: twoHundredCentimetres )! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 00:50:58'!
test18IterateOverRangeAndAddThreeCentimetres
	| oneMetre threeMetres threeCentimetres oneHundredAndThreeCentimetres twoHundredAndThreeCentimetres threeHundredAndThreeCentimetres aNewRange|
	oneMetre := Distance withAmount: 1 withUnitOfDistance: Metre new.
	threeMetres := Distance withAmount: 3 withUnitOfDistance: Metre new.
	threeCentimetres := Distance withAmount: 3 withUnitOfDistance: Centimetre new.
	oneHundredAndThreeCentimetres := Distance withAmount: 103 withUnitOfDistance: Centimetre new.
	twoHundredAndThreeCentimetres := Distance withAmount: 203 withUnitOfDistance: Centimetre new.
	threeHundredAndThreeCentimetres := Distance withAmount: 303 withUnitOfDistance: Centimetre new.
	aNewRange := OrderedCollection new.
	oneMetre to: threeMetres by: oneMetre do: [:aDistance | 
		aNewRange add: (aDistance + threeCentimetres)
	].
	self assert: aNewRange = (OrderedCollection with: oneHundredAndThreeCentimetres with: twoHundredAndThreeCentimetres with: threeHundredAndThreeCentimetres )! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'amount unitOfDistance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:16:14'!
* aMultiplier
	^self class withAmount: amount * aMultiplier withUnitOfDistance: unitOfDistance copy.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:17:20'!
+ aDistance 
	| minUnitOfDistance|
	minUnitOfDistance := unitOfDistance compareWithAndReturnLower: aDistance unitOfDistance.
	^self class withAmount: (self convertTo: minUnitOfDistance) amount + (aDistance convertTo: minUnitOfDistance) amount withUnitOfDistance: minUnitOfDistance copy.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:17:00'!
- aDistance 
	| minUnitOfDistance|
	minUnitOfDistance := unitOfDistance compareWithAndReturnLower: aDistance unitOfDistance.
	^self class withAmount: (self convertTo: minUnitOfDistance) amount - (aDistance convertTo: minUnitOfDistance) amount withUnitOfDistance: minUnitOfDistance copy.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:16:33'!
/ aDivisor 
	^self class withAmount: amount/2 withUnitOfDistance: unitOfDistance copy.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:30:31'!
< aDistance 
	^aDistance > self! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:33:34'!
<= aDistance 
	^aDistance >= self! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:18:18'!
= aDistance
	^(aDistance convertTo: unitOfDistance) amount = amount
	
	! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:28:21'!
> aDistance 
	^(self convertTo: Metre new) amount > (aDistance convertTo: Metre new) amount! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:32:43'!
>= aDistance 
	^(self convertTo: Metre new) amount >= (aDistance convertTo: Metre new) amount! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 23:24:03'!
adaptToNumber: aNumber andSend: aSymbol 
	^self perform: aSymbol with: aNumber ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 20:12:50'!
amount
	^amount! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:08:24'!
convertTo: aUnitOfDistance 
	^self class withAmount: amount / self unitOfDistance ratioToMetre * aUnitOfDistance ratioToMetre withUnitOfDistance: aUnitOfDistance! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 00:34:42'!
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

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 00:34:18'!
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

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 00:51:56'!
to: aDistance by: aStepDistance do: aMethod 
	(self to: aDistance by:aStepDistance) do: aMethod.! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 20:12:30'!
unitOfDistance
	^unitOfDistance ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 20:11:30'!
withAmount: anAmount withUnitOfDistance: aUnitOfDistance 
	amount := anAmount.
	unitOfDistance := aUnitOfDistance.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 20:12:00'!
withAmount: anAmount withUnitOfDistance: aUnitOfDistance 
	^self new withAmount:anAmount withUnitOfDistance:aUnitOfDistance! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:11:35'!
minusOneMeter
	^Distance withAmount: -1 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:11:58'!
oneCentimeter
	^Distance withAmount: 1 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:12:14'!
oneHundredCentimeters 
	^Distance withAmount: 100 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:12:32'!
oneMeter
	^Distance withAmount: 1 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:13:17'!
twoHundredCentimeters 
	^Distance withAmount: 200 withUnitOfDistance: Centimetre new.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:13:33'!
twoMeters  
	^Distance withAmount: 2 withUnitOfDistance: Metre new.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DIC 5/29/2017 21:16:38'!
zeroMeters
	^Distance withAmount: 0 withUnitOfDistance: Metre new.! !


!classDefinition: #UnitOfDistance category: #'Distance-Solution'!
Object subclass: #UnitOfDistance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!UnitOfDistance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:53:29'!
compareWithAndReturnLower: aUnitOfDistance
	self ratioToMetre > aUnitOfDistance ratioToMetre ifTrue: [^self].
	^aUnitOfDistance
! !

!UnitOfDistance methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:53:43'!
ratioToMetre
	self subclassResponsibility 
! !


!classDefinition: #Centimetre category: #'Distance-Solution'!
UnitOfDistance subclass: #Centimetre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Centimetre methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:09:03'!
ratioToMetre
	^100! !


!classDefinition: #Kilometre category: #'Distance-Solution'!
UnitOfDistance subclass: #Kilometre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Kilometre methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:26:24'!
ratioToMetre
	^0.001! !


!classDefinition: #Metre category: #'Distance-Solution'!
UnitOfDistance subclass: #Metre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Metre methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:08:48'!
ratioToMetre
	^1! !


!classDefinition: #Millimetre category: #'Distance-Solution'!
UnitOfDistance subclass: #Millimetre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Millimetre methodsFor: 'as yet unclassified' stamp: 'DIC 5/28/2017 22:31:16'!
ratioToMetre
	^1000! !
