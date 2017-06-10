!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:18:25'!
test01 
	self assert: MeasureFactory oneMeter = MeasureFactory oneMeter! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:19:21'!
test02
	self assert: MeasureFactory oneMeter = MeasureFactory hundredCentimeters! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:37:05'!
test03
	self deny: MeasureFactory oneMeter = MeasureFactory oneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:25:04'!
test04
	self assert: MeasureFactory zeroMeters = MeasureFactory zeroDollars! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:56:40'!
test05
	self assert: MeasureFactory oneMeter + MeasureFactory oneMeter = MeasureFactory twoMeters! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 18:01:40'!
test06
	self assert: MeasureFactory oneMeter + MeasureFactory oneDollar = MeasureFactory oneMeterAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:37:27'!
test07
	self assert: MeasureFactory oneMeterAndOneDollar + MeasureFactory oneMeter = MeasureFactory twoMetersAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:45:50'!
test08
	self assert: MeasureFactory oneMeter + MeasureFactory oneMeterAndOneDollar = MeasureFactory twoMetersAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:05:01'!
test09
	self assert: MeasureFactory oneMeterAndOneDollar + MeasureFactory oneMeterAndOneGram = MeasureFactory twoMetersOneDollarAndOneGram! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:45:30'!
test10
	self assert: MeasureFactory twoMeters - MeasureFactory hundredCentimeters = MeasureFactory oneMeter ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:53:46'!
test11
	self assert: MeasureFactory oneMeterAndOneDollar - MeasureFactory oneMeter = MeasureFactory zeroMetersAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:56:43'!
test12
	self assert: MeasureFactory oneMeterAndOneDollar - MeasureFactory oneMeterAndOneGram = MeasureFactory zeroMetersMinusOneGramAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:08:37'!
test13
	self assert: MeasureFactory oneMeter * 2 = MeasureFactory twoMeters.
	self assert: 2 * MeasureFactory oneMeter = MeasureFactory twoMeters.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:18:10'!
test14
	self assert: MeasureFactory fourMeters / 2 = MeasureFactory twoMeters.
	self assert: MeasureFactory oneMeter/3 = MeasureFactory oneThirdMeter.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 11:49:08'!
test15
	self assert: (MeasureFactory oneMeter convertTo: UnitFactory centimeter) = MeasureFactory hundredCentimeters.
	self should: [
			MeasureFactory oneMeter convertTo: UnitFactory gram]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText =  'Cant convert to unrelated unit']! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:16:01'!
test16
	self assert: (MeasureFactory zeroCelsius convertTo: UnitFactory kelvin) = MeasureFactory twoHundredAndThreeAndSomeKelvin.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:23:54'!
test17
	self assert: 0 * UnitFactory kelvin = MeasureFactory zeroKelvin.
	self assert: UnitFactory meter * 2 = MeasureFactory twoMeters.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:34:30'!
test18
	self assert: MeasureFactory oneMeter * MeasureFactory oneMeter = MeasureFactory oneSquaredMeter.
	self assert: MeasureFactory oneMeter * MeasureFactory zeroKelvin  = MeasureFactory zeroKelvin.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:52:03'!
test19
	self assert: MeasureFactory oneMeter / MeasureFactory oneSecond = MeasureFactory oneMeterPerSecond.! !


!classDefinition: #CompoundMeasure category: #'Measure-Solution'!
Object subclass: #CompoundMeasure
	instanceVariableNames: 'amount units multiplyingUnits dividingUnits'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:23:34'!
= aCompoundMeasure
	^(amount = 0 and: [^aCompoundMeasure compareWithNoAmount]) or: [(self hasSameUnits: aCompoundMeasure) and: [amount = (aCompoundMeasure convertToSameUnitAs: self) amount]]! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:47:44'!
amount
	^amount! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:28:11'!
convertToSameUnitAs: aCompoundMeasure
	| numerator denominator |
	numerator := amount numerator.
	denominator := amount denominator.
	multiplyingUnits do: [:anUnit | 
		numerator := anUnit convertTo: numerator
	].
	aCompoundMeasure multiplyingUnits do: [:anUnit | 
		numerator := anUnit convertTo: numerator
	].
	dividingUnits do: [:anUnit | 
		denominator := anUnit convertTo: denominator 
	].
	aCompoundMeasure dividingUnits do: [:anUnit | 
		denominator := anUnit convertTo: denominator 
	].
	^self class withAmount: (numerator / denominator) asFraction multiplyingUnits: aCompoundMeasure multiplyingUnits dividingUnits: aCompoundMeasure dividingUnits 
	! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:25:07'!
dividingUnits
	^dividingUnits! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:09:02'!
hasSameUnits: aCompoundMeasure 
	^(multiplyingUnits hasEqualElements: aCompoundMeasure dividingUnits) and: (dividingUnits hasEqualElements: aCompoundMeasure dividingUnits)! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:24:56'!
multiplyingUnits
	^multiplyingUnits! !

!CompoundMeasure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:03:23'!
withAmount: anAmount multiplyingUnits: aUnitCollection dividingUnits: anotherUnitCollection
	amount := anAmount.
	multiplyingUnits := aUnitCollection.
	dividingUnits := aUnitCollection.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundMeasure class' category: #'Measure-Solution'!
CompoundMeasure class
	instanceVariableNames: ''!

!CompoundMeasure class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:30:02'!
withAmount: anAmount multiplyingUnits: aUnitCollection dividingUnits: anotherUnitCollection 
	^self new withAmount: anAmount asFraction multiplyingUnits: (OrderedCollection withAll: aUnitCollection) dividingUnits: (OrderedCollection withAll: anotherUnitCollection )! !

!CompoundMeasure class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:29:53'!
withAmount: anAmount withUnits: aUnitCollection
	^self withAmount: anAmount multiplyingUnits: (OrderedCollection withAll: aUnitCollection) dividingUnits: OrderedCollection new.
	! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:51:06'!
* aMultiplier
	(aMultiplier isKindOf: Number) ifFalse: [^CompoundMeasure withAmount: aMultiplier amount * amount withUnits: { unit . aMultiplier unit }].
	^self class withAmount: amount * aMultiplier withUnit: unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/7/2017 23:54:48'!
+ anAdder
	^anAdder addMeasure: self! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:47:48'!
- aMeasure 
	^self + aMeasure negated! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:59:59'!
/ aDivider
	(aDivider isKindOf: Number) ifFalse: [^CompoundMeasure withAmount: aDivider amount * amount multiplyingUnits: { unit } dividingUnits: {aDivider unit}].
	^self class withAmount: (amount / aDivider) asFraction withUnit: unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:22:57'!
= aMeasure
	^(amount = 0 and: [^aMeasure compareWithNoAmount]) or: [(aMeasure isKindOf: self class ) and: [amount = (aMeasure convertTo: unit) amount]]
	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:12:58'!
adaptToNumber: aScalar andSend: aSymbol 
	^self perform: aSymbol with: aScalar! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:10:35'!
addMeasure: aMeasure
	| convertedMeasure |
	(aMeasure isKindOf: self class) ifFalse: [^MeasureGroup with: self with: aMeasure].
	convertedMeasure := aMeasure convertTo: unit.
	^aMeasure class withAmount: amount + convertedMeasure amount withUnit: unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:35:55'!
addToMeasureGroup: aMeasureGroup
	^aMeasureGroup addMeasure: self! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:32:16'!
amount
	^amount ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:35:44'!
compareWithNoAmount
	^amount = 0! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:53:06'!
convertTo: anUnit 
	(anUnit measures: self class) ifFalse: [self error: 'Cant convert to unrelated unit'].
	^self class withAmount: (anUnit convertFrom: (unit convertTo: amount)) withUnit: anUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:09:32'!
hash
	^('{}-{}' format: {self class name . amount asString}) hash! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:55:09'!
isZero
	^amount isZero ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:11:07'!
negated
	^self class withAmount: amount negated withUnit: unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:03:30'!
removeFromMeasureGroup: aMeasureGroup
	^aMeasureGroup addMeasure: self negated! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 14:39:07'!
unit
	^unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:20:11'!
withAmount: anAmount withUnit: anUnit 
	amount := anAmount.
	unit := anUnit.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 16:28:52'!
withAmount: anAmount withUnit: anUnit
	^self new withAmount: anAmount asFraction withUnit: anUnit! !


!classDefinition: #Currency category: #'Measure-Solution'!
Measure subclass: #Currency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Distance category: #'Measure-Solution'!
Measure subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Distance methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 12:19:28'!
baseUnit
	^UnitFactory meter! !


!classDefinition: #Mass category: #'Measure-Solution'!
Measure subclass: #Mass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Mass methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:50:22'!
baseUnit
	^UnitFactory kilogram! !


!classDefinition: #Temperature category: #'Measure-Solution'!
Measure subclass: #Temperature
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #TimeMeasure category: #'Measure-Solution'!
Measure subclass: #TimeMeasure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:22:43'!
celsius
	^UnitFactory celsius! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:10:15'!
centimeter
	^UnitFactory centimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:30:56'!
cubicMeter
	^{ self meter. self meter . self meter}! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:26:24'!
day
	^UnitFactory day! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:10:35'!
decameter
	^UnitFactory decameter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:10:27'!
decimeter
	^UnitFactory decimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:32:05'!
eightCubicMeters
	^CompoundMeasure withAmount: 8 withUnits: self cubicMeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:22:25'!
fahrenheit
	^UnitFactory fahrenheit ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:40:55'!
finalSpeedStartingAt: aCompoundMeasure accelerating: anotherCompoundMeasure during: aTimeMeasure
	^aCompoundMeasure + (anotherCompoundMeasure * aTimeMeasure) ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:13:16'!
fourMeters
	^Distance withAmount: 4 withUnit: UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:31:55'!
fourSquareMeters
	^CompoundMeasure withAmount: 4 withUnits: self squareMeter ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:10:47'!
hectometer
	^UnitFactory hectometer! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:26:30'!
hour
	^UnitFactory hour! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:14:37'!
hundredCentimeters
	^Distance withAmount: 100 withUnit: UnitFactory centimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:22:34'!
kelvin
	^UnitFactory kelvin ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:10:59'!
kilometer
	^UnitFactory kilometer! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:43:41'!
meter
	^UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:11:10'!
millimeter
	^UnitFactory millimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:11:51'!
minusOneMeter
	^Distance withAmount: -1 withUnit: self meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:26:37'!
minute
	^UnitFactory minute! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:14:26'!
oneCelsius
	^Temperature withAmount: 1 withUnit: self celsius! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:12:25'!
oneCentimeter
	^Distance withAmount: 1 withUnit: self centimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:27:15'!
oneDay
	^TimeMeasure withAmount: 1 withUnit: self day! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:15:25'!
oneDollar
	^Currency withAmount: 1 withUnit: UnitFactory dollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:16:57'!
oneGram
	^Mass withAmount: 1 withUnit: UnitFactory gram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:27:24'!
oneHour
	^TimeMeasure withAmount: 1 withUnit: self hour! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:13:20'!
oneHundredCentimeters
	^Distance withAmount: 100 withUnit: self centimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:33:10'!
oneHundredTwentyOneMetersPerSecond
	^CompoundMeasure withAmount: 121 multiplyingUnits: {self meter} dividingUnits: {self second}! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:16:50'!
oneMeter
	^Distance withAmount: 1 withUnit: UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:18:51'!
oneMeterAndOneDollar
	^MeasureGroup with: self oneMeter with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:08:39'!
oneMeterAndOneGram
	^MeasureGroup with: MeasureFactory oneMeter with: MeasureFactory oneGram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:33:27'!
oneMeterPerSecond
	^CompoundMeasure withAmount: 1 multiplyingUnits: {self meter} dividingUnits: {self second}! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:27:32'!
oneMinute
	^TimeMeasure withAmount: 1 withUnit: self minute! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:27:42'!
oneSecond
	^TimeMeasure withAmount: 1 withUnit: self second! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:33:51'!
oneSquaredMeter
	^CompoundMeasure withAmount: 1 withUnits: self squareMeter ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:35:45'!
oneSquaredSecond
	^CompoundMeasure withAmount: 1 withUnits: { self second . self second }! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:16:43'!
oneThirdMeter
	^Distance withAmount: 1/3 withUnit: UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:26:44'!
second
	^UnitFactory second! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:28:06'!
sixtyMinutes
	^TimeMeasure withAmount: 60 withUnit: self minute! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:28:23'!
sixtyOneSeconds
	^TimeMeasure withAmount: 61 withUnit: self second! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:28:34'!
sixtySeconds
	^TimeMeasure withAmount: 60 withUnit: self second! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:31:16'!
squareMeter
	^{ self meter. self meter}! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:15:05'!
thirtyTwoFahrenheits
	^Temperature withAmount: 32 withUnit: self fahrenheit! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:28:52'!
twentyFourHours
	^TimeMeasure withAmount: 24 withUnit: self hour! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:15:26'!
twoCelsius
	^Temperature withAmount: 2 withUnit: self celsius! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 14:12:07'!
twoHundredAndThreeAndSomeKelvin
	^Temperature withAmount: 273.15 withUnit: UnitFactory kelvin ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:13:10'!
twoHundredCentimeters
	^Distance withAmount: 200 withUnit: self centimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:17:11'!
twoMeters
	^Distance withAmount: 2 withUnit: UnitFactory meter.! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:22:47'!
twoMetersAndOneDollar
	^MeasureGroup with: self twoMeters with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:36:33'!
twoMetersBySecond
	^CompoundMeasure withAmount: 2 withUnits: { self meter . self second }! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:09:54'!
twoMetersOneDollarAndOneGram
	^MeasureGroup with: MeasureFactory twoMeters with: MeasureFactory oneDollar with: MeasureFactory oneGram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:37:26'!
twoMetersPerSquaredSecond
	^CompoundMeasure withAmount: 2 multiplyingUnits: { self meter } dividingUnits: { self second . self second }! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:38:18'!
twoMetersTimesSecond
	^self twoMetersBySecond ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:29:05'!
twoSeconds
	^TimeMeasure withAmount: 2 withUnit: self second! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:15:43'!
zeroCelsius
	^Temperature withAmount: 0 withUnit: self celsius! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 11:54:37'!
zeroCentigrades
	^Temperature withAmount: 0 withUnit: UnitFactory centrigrade! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:17:28'!
zeroDollars
	^Currency withAmount: 0 withUnit: UnitFactory dollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:23:15'!
zeroKelvin
	^Temperature withAmount: 0 withUnit: self kelvin ! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:17:53'!
zeroMeters
	^Distance withAmount: 0 withUnit: UnitFactory meter.! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:55:17'!
zeroMetersAndOneDollar
	^MeasureGroup with: self zeroMeters with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:59:43'!
zeroMetersMinusOneGramAndOneDollar
	^MeasureGroup with: self zeroMeters with: self oneGram negated with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:29:17'!
zeroSeconds
	^TimeMeasure withAmount: 0 withUnit: self second! !


!classDefinition: #MeasureGroup category: #'Measure-Solution'!
Object subclass: #MeasureGroup
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:35:30'!
+ anAdder
	^anAdder addToMeasureGroup: self! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:27:03'!
- anAdder
	^anAdder removeFromMeasureGroup: self.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:43:57'!
= aMeasureGroup
	^contents = aMeasureGroup contents! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:34:59'!
addMeasure: aMeasure 
	contents
		at: aMeasure class name
		ifPresent: [:existingMeasure | contents at: existingMeasure class name put: existingMeasure + aMeasure]
		ifAbsent: [ contents at: aMeasure class name put: aMeasure ].
	^self.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:33:28'!
addToMeasureGroup: aMeasureGroup
	self contents do: [:aMeasure | aMeasureGroup addMeasure: aMeasure].
	^aMeasureGroup .! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:44:12'!
contents
	^contents! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:58:00'!
initialize
	contents := Dictionary new.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:02:35'!
removeFromMeasureGroup: aMeasureGroup
	self contents do: [:aMeasure | aMeasureGroup addMeasure: aMeasure negated].
	^aMeasureGroup .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureGroup class' category: #'Measure-Solution'!
MeasureGroup class
	instanceVariableNames: ''!

!MeasureGroup class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:21:31'!
with: aMeasure with: anotherMeasure 
	| aMeasureGroup|
	aMeasureGroup :=  self new.
	aMeasureGroup + aMeasure.
	aMeasureGroup + anotherMeasure.
	^aMeasureGroup! !

!MeasureGroup class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:11:35'!
with: aMeasure with: anotherMeasure with: yetAnotherMeasure
	| measureGroup |
	measureGroup := self new.
	measureGroup + aMeasure.
	measureGroup + anotherMeasure.
	measureGroup + yetAnotherMeasure.
	^measureGroup! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'unitName measure converterTo converterFrom'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 14:17:19'!
* aScalar
	^measure withAmount: aScalar withUnit: self! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:38:36'!
= anUnit
	^unitName = anUnit unitName! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 14:16:37'!
adaptToNumber: aScalar andSend: aSymbol 
	^self perform: aSymbol with: aScalar! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 12:32:03'!
convertFrom: anAmount
	^converterFrom value: anAmount ! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 12:31:54'!
convertTo: anAmount
	^converterTo value: anAmount ! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:10:04'!
hash
	^'{}-{}' format: { self class name . unitName } hash! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:53:58'!
measures: aMeasureClass 
	^measure = aMeasureClass ! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 12:30:31'!
named: aString of: aMeasureClass withConverterTo: aConverterMethod withConverterFrom: anotherConverterMethod
	unitName := aString.
	measure := aMeasureClass.
	converterTo := aConverterMethod.
	converterFrom := anotherConverterMethod.
	^self.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:38:53'!
unitName
	^unitName ! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:56:42'!
withName: aString ofMeasure: aMeasureClass withConverterTo: aConversionToBaseUnitMethod withConverterFrom: aConversionFromBaseUnitMethod
	unitName := aString.
	measure := aMeasureClass.
	converterTo := aConversionToBaseUnitMethod .
	converterFrom := aConversionFromBaseUnitMethod.
	^self! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:49:13'!
withName: aString ofMeasure: aMeasureClass withRatio: ratioToBaseUnit 
	unitName := aString.
	measure := aMeasureClass.
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 12:27:37'!
named: aString of: aMeasureClass withConverterTo: aConverterMethod withConverterFrom: anotherConverterMethod
	^self new withName: aString ofMeasure: aMeasureClass withConverterTo: aConverterMethod withConverterFrom: anotherConverterMethod! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:58:15'!
named: aString of: aMeasureClass withRatio: ratioToBaseUnit
	^self named: aString of: aMeasureClass withConverterTo: [:anAmount | anAmount * ratioToBaseUnit] withConverterFrom: [:anAmount | anAmount / ratioToBaseUnit]! !


!classDefinition: #UnitFactory category: #'Measure-Solution'!
Object subclass: #UnitFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitFactory class' category: #'Measure-Solution'!
UnitFactory class
	instanceVariableNames: ''!

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:16:40'!
celsius
	^Unit named: #celsius of: Temperature withRatio: 1.! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:44:33'!
centimeter
	^Unit named: 'centimeter' of:Distance withRatio: 1/100! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 11:55:48'!
centrigrade
	^Unit named: 'centrigrade' of: Temperature withRatio: 1.! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:25:20'!
day
	^Unit named: #day of: TimeMeasure withRatio: 86400! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:07:40'!
decameter
	^Unit named: #decameter of: Distance withRatio: 10! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:08:01'!
decimeter
	^Unit named: #decimeter of: Distance withRatio: 1/10! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:24:22'!
dollar
	^Unit named: 'dollar' of: Currency withRatio: 1! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:21:25'!
fahrenheit
	^Unit named: #fahrenheit of: Temperature withConverterTo: [:anAmount | anAmount - 32 * 5/9] withConverterFrom: [:anAmount | anAmount * 9/5 + 32]! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:50:58'!
gram
	^Unit named: 'gram' of: Mass withRatio: 1/1000! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:08:24'!
hectometer
	^Unit named: #hectometer of: Distance withRatio: 100! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:25:48'!
hour
	^Unit named: #hour of: TimeMeasure withRatio: 3600! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 14:11:01'!
kelvin
	^Unit named: 'kelvin' of: Temperature withConverterTo: [:anAmount | anAmount - 273.15] withConverterFrom: [:anAmount | anAmount + 273.15].! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 13:50:48'!
kilogram
	^Unit named: 'kilogram' of: Mass withRatio: 1! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:08:42'!
kilometer
	^Unit named: #kilometer of: Distance withRatio: 1000! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:19:22'!
meter
	^Unit named: 'meter' of: Distance withRatio: 1! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:09:00'!
millimeter
	^Unit named: #millimeter of: Distance withRatio: 1/1000! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 17:26:03'!
minute
	^Unit named: #minute of: TimeMeasure withRatio: 60! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 15:54:06'!
second
	^Unit named: #second  of: TimeMeasure  withRatio: 1! !
