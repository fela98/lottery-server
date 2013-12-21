package {

	import flash.display.MovieClip;
	import flash.geom.*;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.GradientType;
	import com.piterwilson.visualization.PieChart.*;
	import com.piterwilson.drawing.CakeSlice;
	import com.piterwilson.utils.Tooltip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.*;
	import flash.display.BlendMode;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Graphics;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.geom.ColorTransform;
	import flash.media.*;
	import flash.text.*;
	import flash.net.URLRequest;
	import flash.utils.*;
	import Math;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	//import com.freeactionscript.effects.explosion.MediumExplosion;
	// Others classes -----------------
	import com.greensock.*;
	import com.greensock.easing.*;


	public class Loddtrekning extends MovieClip {

		var winLetter: String;
		var winNumber: int;
		var winId: int;
		var numberChooser: int

		var fjernVinnerloddIsChecked: Boolean
		var waitForRightIsChecked: Boolean


		var pie: PieChart = new PieChart();
		var contWheel: MovieClip = new MovieClip();
		var shaddow: DropShadowFilter = new DropShadowFilter(0, 0, 0x000000, 0.3, 10, 10, 2, 3, false, false, false);
		var shaddowSmall: DropShadowFilter = new DropShadowFilter(0, 0, 0x000000, 0.3, 3, 3, 2, 3, false, false, false);
		var radius: int = 270;
		var pil: lib_pil;



		var vinnerlodd: lib_winnerlodd;
		var randomLodd: lib_winnerlodd;

		// MUST BE CHANGED ----------
		var aBlock1: Array;
		var aBlock2: Array;
		var aBlock3: Array;
		var aBlock4: Array;
		var aBlock5: Array;
		var aBlock6: Array;
		var aBlock7: Array;
		var aBlock8: Array;
		var aBlock9: Array;
		var aBlock10: Array;
		var aBlock11: Array;
		var aBlock12: Array;
		var aBlock13: Array;
		var aBlock14: Array;
		var aBlock15: Array;
		var aBlock16: Array;
		// ---------------------------

		var aBlokker: Array;
		var aFarger: Array;
		var aBokstaver: Array;
		var aProsent: Array;
		var aGrader: Array;

		var secondsToWait: int;

		var timeoutInterval: int;

		var aNumberHolder: Array;

		var chooser: lib_chooser;

		var contNumbers: Sprite;
		var contOverlay: Sprite;
		var totalAntallLodd: int;
		var totalAntallProsentFordelt: int;

		var soundPad: sndPad;
		var soundFanfare: fanfare;
		var soundPadNumbers: padNumbers;
		var soundfirstcheers: firstcheer;


		var soundChannel: SoundChannel;


		public function Loddtrekning() {

			stage.scaleMode = StageScaleMode.NO_BORDER;

			loadImage();

			grensesnitt.waitForRight.addEventListener(MouseEvent.CLICK, checkWaitForSeconds);

			function checkWaitForSeconds() {
				if (grensesnitt.waitForRight.selected == true) {
					grensesnitt.waitSecondsContainer.visible = true;
				}
				if (grensesnitt.waitForRight.selected == false) {
					grensesnitt.waitSecondsContainer.visible = false;
				}
			}

			grensesnitt.saveAndStart.addEventListener(MouseEvent.CLICK, PieChartTest1);
		}



		public function PieChartTest1(event: MouseEvent): void {


			function min2max(min_uint: uint, max_uint: uint): Array {
				var temp_arr: Array = new Array();
				if (min_uint < max_uint) {
					for (var i: uint = min_uint; i <= max_uint; i++) {
						temp_arr.push(i);
					}
					return temp_arr;
				} else {
					return null;
				}
			}

			//						--->USER INTERFACE ASSIGNMENTS<---

			waitForRightIsChecked = grensesnitt.waitForRight.selected;
			secondsToWait = int(grensesnitt.waitSecondsContainer.waitSeconds.text)

			aBlock1 = min2max(int(grensesnitt.fra1.text), int(grensesnitt.til1.text));
			aBlock2 = min2max(int(grensesnitt.fra2.text), int(grensesnitt.til2.text));
			aBlock3 = min2max(int(grensesnitt.fra3.text), int(grensesnitt.til3.text));
			aBlock4 = min2max(int(grensesnitt.fra4.text), int(grensesnitt.til4.text));
			aBlock5 = min2max(int(grensesnitt.fra5.text), int(grensesnitt.til5.text));
			aBlock6 = min2max(int(grensesnitt.fra6.text), int(grensesnitt.til6.text));
			aBlock7 = min2max(int(grensesnitt.fra7.text), int(grensesnitt.til7.text));
			aBlock8 = min2max(int(grensesnitt.fra8.text), int(grensesnitt.til8.text));
			aBlock9 = min2max(int(grensesnitt.fra9.text), int(grensesnitt.til9.text));
			aBlock10 = min2max(int(grensesnitt.fra10.text), int(grensesnitt.til10.text));
			aBlock11 = min2max(int(grensesnitt.fra11.text), int(grensesnitt.til11.text));
			aBlock12 = min2max(int(grensesnitt.fra12.text), int(grensesnitt.til12.text));
			aBlock13 = min2max(int(grensesnitt.fra13.text), int(grensesnitt.til13.text));

			aBlokker = new Array(aBlock1, aBlock2, aBlock3, aBlock4, aBlock5, aBlock6, aBlock7, aBlock8, aBlock9, aBlock10, aBlock11, aBlock12, aBlock13);
			fjernVinnerloddIsChecked = grensesnitt.fjernVinnerlodd.selected;


			trace("1. Bokstav " + grensesnitt.Bokstav1.text);

			aBokstaver = new Array(grensesnitt.Bokstav1.text.toUpperCase(), grensesnitt.Bokstav2.text.toUpperCase(),
				grensesnitt.Bokstav3.text.toUpperCase(), grensesnitt.Bokstav4.text.toUpperCase(),
				grensesnitt.Bokstav5.text.toUpperCase(), grensesnitt.Bokstav6.text.toUpperCase(),
				grensesnitt.Bokstav7.text.toUpperCase(), grensesnitt.Bokstav8.text.toUpperCase(),
				grensesnitt.Bokstav9.text.toUpperCase(), grensesnitt.Bokstav10.text.toUpperCase(),
				grensesnitt.Bokstav11.text.toUpperCase(), grensesnitt.Bokstav12.text.toUpperCase(),
				grensesnitt.Bokstav13.text.toUpperCase());


			var j: uint = 0;
			while (j < aBokstaver.length) {
				if (aBokstaver[j] == "") {
					aBokstaver.splice(j);
				}
				j++;
			}

			while (aBlokker.length > aBokstaver.length) {
				aBlokker.pop();
			}

			trace("Antall Bokstaver: " + aBokstaver.length);
			trace("Antall Blokker: " + aBlokker.length);

			aFarger = new Array(grensesnitt.farge1.selectedItem.data, grensesnitt.farge2.selectedItem.data,
				grensesnitt.farge3.selectedItem.data, grensesnitt.farge4.selectedItem.data,
				grensesnitt.farge5.selectedItem.data, grensesnitt.farge6.selectedItem.data,
				grensesnitt.farge7.selectedItem.data, grensesnitt.farge8.selectedItem.data,
				grensesnitt.farge9.selectedItem.data, grensesnitt.farge10.selectedItem.data,
				grensesnitt.farge11.selectedItem.data, grensesnitt.farge12.selectedItem.data,
				grensesnitt.farge13.selectedItem.data);

			trace("Farge1 = " + grensesnitt.farge1.selectedItem.data);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);

			// Set up variables
			winLetter = "A";
			winNumber = -1;
			winId = -1;
			totalAntallLodd = 0;


			// Farger
			var Rosa = 0xED4EDE; // Rosa
			var Nyrosa = 0xE72171; // Nyrosa
			var Blå = 0x5681E4; // Blå
			var Grønn = 0x1FD868; // Grønn
			var Hvit = 0xFFFFFF; // Hvit
			var Lysorange = 0xE7A487; // Lysorange
			var Gulgrønn = 0xBBDE29; // Gulgrønn
			var Gul = 0xFFFF09; // Gul


			// Get total length
			for (var k: int = 0; k < aBlokker.length; k++) {
				totalAntallLodd += aBlokker[k].length;
			}

			trace("Antall lodd: " + totalAntallLodd);

			aProsent = new Array();

			// Calculate prosent
			for (var f: int = 0; f < aBokstaver.length; f++) {
				trace("Lengde blokk " + f + ": " + aBlokker[f].length);
				aProsent[f] = Number((aBlokker[f].length / totalAntallLodd) * 100);
				totalAntallProsentFordelt += aProsent[f];
			}

			trace("Totalt prosenter: " + totalAntallProsentFordelt);


			// -------------------------------------------------

			// Balancing - not needed
			/*var rest:int = 100 - totalAntallProsentFordelt;
			trace("Rest: " + rest);
			var counter:int = 0;
			for (var o:int = rest; rest > 0; rest--)
			{
			trace("Fordeler...");
			if (counter > aProsent.length)
			{
			counter = 0;
			}
			aProsent[counter]++;
			counter++;
			
			}*/

			// Set up containers and objects
			contNumbers = new Sprite();
			contNumbers.x = stage.stageWidth / 2;
			contNumbers.y = (stage.stageHeight / 2);
			addChild(contNumbers);

			chooser = new lib_chooser();
			chooser.x = stage.stageWidth / 2;
			chooser.y = stage.stageHeight / 2;
			chooser.alpha = 0;
			addChild(chooser);

			vinnerlodd = new lib_winnerlodd();
			vinnerlodd.x = stage.stageWidth / 2;
			vinnerlodd.y = stage.stageHeight / 2;
			vinnerlodd.filters = [shaddow];
			vinnerlodd.name = "lodd";


			soundPad = new sndPad();
			soundPad.volume = 1;
			soundFanfare = new fanfare();
			soundFanfare.volume = 1;
			soundPadNumbers = new padNumbers();
			soundPadNumbers.volume = 1;
			soundfirstcheers = new firstcheer();
			soundfirstcheers.volume = 0.7;

			soundChannel = new SoundChannel();
			resetAll();
			//initWheel();
			//initAndRunNumber();

		}



		// ----------------
		// NUMBER FUNCTIONS
		// ----------------

		// First alternative - numbers are spinned with 2 characters and these two charachters decide the winning number.

		public function loddSirkel() {
			var radius: int = 400;
			var antallLodd: int = 10;
			var uttrekteLodd: Array = new Array();
			var currentLodd: int;

			soundChannel.stop();
			soundChannel = soundPadNumbers.play();

			for (var i: int = 0; i < antallLodd; i++) {
				currentLodd = getRandomElementOf(aBlokker[winId]).valueOf();
				if (uttrekteLodd.indexOf(currentLodd)) {
					uttrekteLodd[i] = currentLodd;
				}


			}


			var uttrekteLoddMC: Array = new Array();

			var nrColortransform = new ColorTransform();
			nrColortransform.color = aFarger[winId];

			for (i = 0; i < uttrekteLodd.length; i++) {
				uttrekteLoddMC[i] = new lib_number();
				uttrekteLoddMC[i].x = radius * (Math.sin((i / uttrekteLodd.length) * 2 * Math.PI));
				uttrekteLoddMC[i].y = -(radius * (Math.cos((i / uttrekteLodd.length) * 2 * Math.PI)));
				uttrekteLoddMC[i].bcg.transform.colorTransform = nrColortransform;
				uttrekteLoddMC[i].filters = [shaddow];
				contNumbers.addChild(uttrekteLoddMC[i]);
				uttrekteLoddMC[i].alpha = 0;
				uttrekteLoddMC[i].txt.text = uttrekteLodd[i].toString();
				var relationalSize: Number = uttrekteLoddMC[i].width / uttrekteLoddMC[i].height;
				uttrekteLoddMC[i].width = 130;
				uttrekteLoddMC[i].height = uttrekteLoddMC[i].width / relationalSize;
			}
			var lodd: lib_number;

			var newRadius: Number = radius;

			i = 0;
			var timer1: Timer = new Timer(1000, antallLodd);
			timer1.addEventListener(TimerEvent.TIMER, function () {
				TweenMax.to(uttrekteLoddMC[i], 1, {
					alpha: 1,
					onComplete: function () {
						if (i + 1 == antallLodd) {
							decreaseLodd();
						}
					}
				});
				i++;
			})
			timer1.start();
			var isLast: Boolean = false;

			function rearrangeLodd() {
				var xPos: int = 0;
				var yPos: int = 0;
				newRadius -= radius / (antallLodd);
				for (i = 0; i < uttrekteLoddMC.length; i++) {
					isLast = false;
					if (uttrekteLoddMC.length == 1) {
						isLast = true;
					} else {
						yPos = -(newRadius * (Math.cos((i / uttrekteLoddMC.length) * 2 * Math.PI)));
						xPos = newRadius * (Math.sin((i / uttrekteLoddMC.length) * 2 * Math.PI));
					}

					TweenMax.to(uttrekteLoddMC[i], 1, {
						x: xPos,
						y: yPos,
						onComplete: function () {
							if (isLast) {
								winNumber = uttrekteLoddMC[0].txt.text.valueOf();
								soundChannel.stop();
								soundChannel = soundFanfare.play();


								trace("Win letter: " + winLetter);
								trace("Win number: " + winNumber);

								TweenMax.to(uttrekteLoddMC[0], 0.2, {
									alpha: 1,
									scaleX: 5,
									scaleY: 5,
									delay: 1,
									ease: Expo.easeOut,
									repeat: 15,
									yoyo: true,
									onComplete: showWinnerLodd
								});
							}
						}
					})
				}
			}


			lodd = null;
			function decreaseLodd() {
				var timer2: Timer = new Timer(4000, uttrekteLoddMC.length - 1);
				timer2.addEventListener(TimerEvent.TIMER, removeRandomLodd);
				timer2.start();
				function removeRandomLodd(e: TimerEvent): void {
					lodd = lib_number(getRandomElementOf(uttrekteLoddMC));
					uttrekteLoddMC.splice(uttrekteLoddMC.indexOf(lodd), 1);
					uttrekteLodd.splice(uttrekteLodd.indexOf(lodd.txt.text.valueOf()), 1);

					explode(lodd);
					
					if (isLast) {
						winNumber = uttrekteLoddMC[0].txt.text.valueOf();
						//soundChannel.stop();
						//soundChannel = soundFanfare.play();


						trace("Win letter: " + winLetter);
						trace("Win number: " + winNumber);

						TweenMax.to(uttrekteLoddMC[0], 0.2, {
							alpha: 1,
							scaleX: 5,
							scaleY: 5,
							delay: 1,
							ease: Expo.easeOut,
							repeat: 15,
							yoyo: true,
							onComplete: showWinnerLodd
						});
					}






					rearrangeLodd();
				}
			}
		}

		public function spinNumbers() {


			winNumber = getRandomElementOf(aBlokker[winId]).valueOf();
			var winString: String = String(winNumber);
			var firstNumber: int;
			var secondNumber: int;

			if (winString.length == 1) {
				firstNumber = 0;
				secondNumber = winNumber;
			} else {
				firstNumber = int(winString.substring(winString.length - 2, winString.length - 1));
				secondNumber = int(winString.substring(winString.length - 1));
			}




			trace(winNumber);
			trace(String(firstNumber) + "," + String(secondNumber));


			for (var i: int = spins.numChildren - 1; i >= 0; i--) {
				spins.getChildAt(i).visible = true;
			}

			function createMask() {
				spinMask.cacheAsBitmap = true;
				spins.cacheAsBitmap = true;
				spins.mask = spinMask;
			}

			createMask();

			var nrColortransform = new ColorTransform();

			if (bakgrunnsLoddContainer.bakgrunnsLodd.visible == false) {

				/*bakgrunnsLoddContainer.bakgrunnsLodd.x = 980;
			bakgrunnsLoddContainer.bakgrunnsLodd.y = 545;*/
				bakgrunnsLoddContainer.bakgrunnsLodd.visible = true;

				var dropShadow: DropShadowFilter = new DropShadowFilter();
				dropShadow.color = 0x000000;
				dropShadow.strength = 0.5;
				dropShadow.distance = 5;
				dropShadow.quality = 15;

				var dropShadow0: DropShadowFilter = new DropShadowFilter();
				dropShadow0.color = 0x000000;
				dropShadow0.strength = 0;

				bakgrunnsLoddContainer.filters = new Array(shaddow);
				bakgrunnsLoddContainer.bakgrunnsLodd.filters = new Array(dropShadow0);
			}

			nrColortransform.color = aFarger[winId];

			bakgrunnsLoddContainer.bakgrunnsLodd.transform.colorTransform = nrColortransform;


			if (blitMask1 == null) {

				//displayObject,  x,  y,  width,  height, smoothing, autoUpdate, fillColor,  wrap
				var blitMask1: BlitMask = new BlitMask(spins.strip1, spins.strip1.x, spins.strip1.y, spins.strip1.width, 500, true, true, 0xffff00, true);
				var blitMask2: BlitMask = new BlitMask(spins.strip2, spins.strip2.x, spins.strip2.y, spins.strip2.width, 500, true, true, 0xffff00, true);
			}

			var startPosition: int = 167

			spins.strip1.y = startPosition;
			spins.strip2.y = startPosition;

			this.setChildIndex(spins, this.numChildren - 1)




			function startSpin(): void {
				soundChannel.stop();
				soundChannel = soundPadNumbers.play();

				bakgrunnsLoddContainer.bakgrunnsLodd.visible = true;


				//Hvor mange runder det første og andre sifferet skal ta.
				var antallRunder1: int = 6;
				var antallRunder2: int = 12;

				//Duration in milliseconds
				var duration1: int = 8
				var duration2: int = 15

				var delay1: int = 1;
				var delay2: int = 8;

				// finner sentrum av sifferet
				// [INFO] et siffer har en høyde på 100px
				var finishedPosition1: int = (1000 - (firstNumber * 100)) + (antallRunder1 * 1000);
				var finishedPosition2: int = (1000 - (secondNumber * 100)) + (antallRunder2 * 1000);

				// Gjør det spennende og setter velger først en posisjon ganske midt imellom 2 siffer. Og smetter etterpå til det riktige tallet
				var randomPosition1: int
				var randomPosition2: int

				if (randomBoolean()) {
					randomPosition1 = randomNumber(45, 50);
				} else {
					randomPosition1 = randomNumber(-50, -45);
				}

				if (randomBoolean()) {
					randomPosition2 = randomNumber(45, 50);
				} else {
					randomPosition2 = randomNumber(-50, -45);
				}

				var firstPosition1: int = finishedPosition1 + randomPosition1;
				var firstPosition2: int = finishedPosition2 + randomPosition2;

				//tween to the relative value of firstPosition
				var firstTween1: TweenMax = TweenMax.to(spins.strip1, duration1, {
					y: String(firstPosition1),
					delay: delay1,
					onComplete: runSecondTween1,
					ease: Expo.easeOut
				});
				var firstTween2: TweenMax = TweenMax.to(spins.strip2, duration2, {
					y: String(firstPosition2),
					delay: delay2,
					onComplete: runSecondTween2,
					ease: Expo.easeOut
				});

				function runSecondTween1() {
					var secondTween1: TweenMax = TweenMax.to(spins.strip1, 0.5, {
						y: String(-randomPosition1),
						ease: Circ.easeOut
					});
				}

				function runSecondTween2() {
					var secondTween2: TweenMax = TweenMax.to(spins.strip2, 0.5, {
						y: String(-randomPosition2),
						onComplete: showWin2,
						ease: Circ.easeOut
					});
				}

			}

			startSpin();
			function showWin2() {
				soundChannel.stop();
				soundChannel = soundFanfare.play();

				for (var i: int = spins.numChildren - 1; i >= 0; i--) {
					spins.getChildAt(i).visible = false;
				}

				myText.txt.text = String(winNumber);
				myText.txt.textColor = 0x000000;
				myText.txt.visible = true;

				TweenMax.to(myText, 0.2, {
					alpha: 1,
					scaleX: 4,
					scaleY: 4,
					delay: 1,
					ease: Expo.easeOut,
					repeat: 15,
					yoyo: true
				});
				TweenMax.to(bakgrunnsLoddContainer.bakgrunnsLodd, 0.2, {
					alpha: 1,
					scaleX: 4,
					scaleY: 4,
					delay: 1,
					ease: Expo.easeOut,
					repeat: 15,
					yoyo: true,
					onComplete: ferdig
				});
			}

			function ferdig() {
				trace("Ferdig!");
				removeVinnerLodd();
				showWinnerLodd();
			}
		}

		// ett lodd som bytter nummer tilfeldig, og tils slutt lander på det avgjørende nummeret
		// !!! IKKE FERDIG !!!

		/*public function ettLodd()
		{
			randomLodd = new lib_winnerlodd();
			randomLodd.letter.text = winLetter;
			randomLodd.x = stage.stageWidth / 2;
			randomLodd.y = stage.stageHeight / 2;
			randomLodd.name = "randomLodd";
			addChild(randomLodd);
			
			
			var duration:int = 100;
			var Changes:int = Math.round(randomNumber(20,30));
			var myInterval:uint = setInterval(changeNumber,duration);

			function changeNumber()
			{
				randomLodd.nr.text = String(randomNumber(aBlokker[winId][0],aBlokker[winId].length - 1));
				Changes -=  1;

				if (Changes < 0)
				{
					clearInterval(myInterval);
				}
			}


			while (0 < Changes)
			{
			clearInterval(myTimeout:uint);
			Changes -=  1;
			}

		}
		*/

		// antall lodd er på stagen, en selector velger 2-7 (før 3-6) forskjellige lodd hvorav det siste er det avgjørende.

		public function initAndRunNumber(blokkid: int): void {
			soundChannel.stop();
			soundChannel = soundPadNumbers.play();


			var nrColortransform = new ColorTransform();
			nrColortransform.color = aFarger[blokkid];


			var nrWidth: int = 75;
			var nrMargin: int = 8;
			var numOfTweens: int = randomNumber(2, 7);
			var currentTween: int = 0;
			aNumberHolder = new Array();

			var theblokk: Array = aBlokker[blokkid];

			chooser.alpha = 1;

			for (var i: int = 0; i < theblokk.length; i++) {
				var nr: lib_number = new lib_number();
				nr.x = i * (nr.width + nrMargin);
				nr.y = 0;
				nr.txt.text = String(theblokk[i]);
				nr.filters = [shaddow];
				nr.bcg.transform.colorTransform = nrColortransform;
				contNumbers.addChild(nr);
				aNumberHolder[i] = nr;
			}

			for (var j: int = 0; j < numOfTweens; j++) {

				var rndWinNr: int = randomNumber(1, theblokk.length);
				TweenMax.to(contNumbers, 5, {
					x: contNumbers.x - ((rndWinNr - 1) * (nrWidth + nrMargin)),
					delay: j * 5,
					ease: Expo.easeInOut,
					onComplete: addUpTweens
				});
				winNumber = rndWinNr;

			}

			function addUpTweens(): void {
				currentTween++;
				if (currentTween == numOfTweens) {
					trace("Ferdig!");
					removeVinnerLodd();
					showWin();
				}
			}


		}

		private function showWin(): void {
			soundChannel.stop();
			soundChannel = soundFanfare.play();


			trace("Win letter: " + winLetter);
			trace("Win number: " + winNumber);

			for (var i: int = 0; i < aNumberHolder.length; i++) {
				if (i != winNumber - 1) {
					aNumberHolder[i].alpha = 0;
				}
			}

			TweenMax.to(chooser, 0.5, {
				alpha: 0,
				delay: 0.5,
				ease: Expo.easeOut
			});
			TweenMax.to(aNumberHolder[winNumber - 1], 0.2, {
				alpha: 1,
				scaleX: 5,
				scaleY: 5,
				delay: 1,
				ease: Expo.easeOut,
				repeat: 15,
				yoyo: true,
				onComplete: showWinnerLodd
			});

		}

		private function showWinnerLodd(): void {

			// Clear number container
			while (contNumbers.numChildren > 0) {
				contNumbers.removeChildAt(0);
			}

			TweenMax.killTweensOf(bakgrunnsLoddContainer.bakgrunnsLodd);

			if (bakgrunnsLoddContainer.bakgrunnsLodd.visible) {
				bakgrunnsLoddContainer.bakgrunnsLodd.visible = false;
			}


			aNumberHolder = new Array();
			chooser.alpha = 0;

			vinnerlodd.letter.text = String(winLetter);
			vinnerlodd.nr.text = String(winNumber);
			addChild(vinnerlodd);
		}


		// ---------------
		// WHEEL FUNCTIONS
		// ---------------
		public function initWheel() {

			soundChannel = soundPad.play();

			pie = new PieChart();

			var xpos: int = 0;
			var ypos: int = 0;

			totalAntallLodd = 0;
			totalAntallProsentFordelt = 0;

			Tooltip.setRoot(this);

			// Create container

			contWheel.x = (stage.stageWidth / 2);
			contWheel.y = -500;
			contWheel.name = "wheel";
			addChild(contWheel);

			pie.radius = radius;
			pie.x = xpos;
			pie.y = ypos;
			pie.rotation = -90;
			pie.autoBalance = false; // don't autobalance

			for (var i: int = 0; i < aBokstaver.length; i++) {

				pie.addSlice(aBokstaver[i], aProsent[i], aFarger[i]);
				trace("ADDING SLICE: " + aBokstaver[i] + "-" + aProsent[i]);

			}


			//Sets the color of the "top off" slice (The slice with the remaining precentage)
			//pie.topOffColor=0xefffef
			//pie.TopOffSliceLabel="Missing" // sets the text of the label on the "top off" slcice
			//pie.topOffAlpha=1
			pie.setOuterBorder(10, 0x333333, 1);
			// sets the outer border style;
			pie.setSliceBorder(1, 0x333333, 1);
			// sets the inner border style;
			pie.draw();

			contWheel.addChild(pie);
			addGraphics();
			addArrow();

			contWheel.rotation = 0;

			aGrader = new Array();
			for (var l: int = 0; l < aBlokker.length; l++) {
				aGrader[l] = (360 * (aProsent[l] / 100));
			}

			var randrot: int = randomNumber(3600, 6120);
			var grader = randrot % 360;
			trace("Grader: " + grader);

			var graderCount = 0;

			for (var h: int = 0; h < aGrader.length; h++) {

				if (graderCount <= grader) {
					winLetter = aBokstaver[h];
					winId = h;
				}
				graderCount += aGrader[h];
				trace("Gradercount: " + graderCount);
			}

			trace("Vinnerbokstav: " + winLetter);

			var loddColortransform = new ColorTransform();
			loddColortransform.color = aFarger[winId];
			vinnerlodd.bcg.transform.colorTransform = loddColortransform;

			//contWheel.filters = [shaddow];
			TweenMax.to(contWheel, 2, {
				y: (stage.stageHeight / 2) - (radius) + 335,
				delay: 0,
				ease: Bounce.easeOut
			});
			TweenMax.to(contWheel, randomNumber(15, 23), {
				rotation: randrot,
				delay: 4,
				ease: Quad.easeOut,
				onComplete: doEndWheel
			});

			trace(aGrader);

			trace("Rot: " + contWheel.rotation);
		}

		public function doEndWheel(): void {
			soundChannel.stop();
			soundChannel = soundfirstcheers.play();

			trace("Rot: " + contWheel.rotation);

			if (waitForRightIsChecked) {
				timeoutInterval = setTimeout(initPart2, secondsToWait * 1000)

			}
		}

		public function addArrow(): void {
			pil = new lib_pil();
			pil.x = stage.stageWidth / 2;
			pil.y = stage.stageHeight / 2 - 205;
			pil.filters = [shaddowSmall];
			pil.name = "pilen";
			pil.y = -50;
			pil.alpha = 0;
			addChild(pil);
			TweenMax.to(pil, 2, {
				y: stage.stageHeight / 2 - 205,
				alpha: 1,
				delay: 1,
				ease: Bounce.easeOut
			});
		}

		public function addGraphics(): void {
			var wborder: lib_wheelborder = new lib_wheelborder();
			wborder.x = -512;
			wborder.y = -450;
			//wborder.filters = [shaddowSmall];
			contWheel.addChild(wborder);

			var wgrad: lib_grad = new lib_grad();
			wgrad.x = (stage.stageWidth / 2);
			wgrad.y = (stage.stageHeight / 2) + 200;
			//addChild(wgrad);
		}

		// -----------------
		// GENERAL FUNCTIONS
		// -----------------

		private function explode(exploding: MovieClip) {
			var pixelContainer: MovieClip = new MovieClip();
			var animating: Boolean = false;
			var pixelBMP: BitmapData;
			var myPixel: lib_pixel;

			var i: int = 0;
			var j: int = 0;

			exploding.visible = false;

			pixelBMP = new BitmapData(exploding.width, exploding.height, true, 0x000000);
			pixelBMP.draw(exploding);
			
			trace("pixel at 0,0: " + pixelBMP.getPixel(0,0));
			trace("pixel at 50,50: " + pixelBMP.getPixel(50,50));
			trace("pixel at 100,100: " + pixelBMP.getPixel(100,100));

			for (i = 0; i < exploding.width; i++) {
				for (j = 0; j < exploding.height; j++) {
					if (pixelBMP.getPixel(i, j) > 0) {
						myPixel = new lib_pixel();
						myPixel.setup(pixelBMP.getPixel(i, j), i, j);
						pixelContainer.addChild(myPixel);
						pixelContainer.visible = true;
						pixelContainer.x = exploding.x;
						pixelContainer.y = exploding.y;
					}
				}
			}
			contNumbers.addChild(pixelContainer);
		}

		function getRandomElementOf(array: Array): Object {
			var idx: int = Math.floor(Math.random() * array.length);
			return array[idx];
		}

		function randomBoolean(): Boolean {
			if (Math.random() > 0.5) {
				return true;
			} else {
				return false;
			}
		}

		public function removeVinnerLodd() {
			if (fjernVinnerloddIsChecked) {

				aBlokker[winId].splice(winNumber, 1);

				// Get total length;

				for (var k: int = 0; k < aBlokker.length; k++) {
					totalAntallLodd += aBlokker[k].length;
				}

				trace("Antall lodd: " + totalAntallLodd);


				// Calculate prosent
				for (var f: int = 0; f < aBlokker.length; f++) {
					trace("Lengde blokk " + f + ": " + aBlokker[f].length);
					aProsent[f] = Number((aBlokker[f].length / totalAntallLodd) * 100);
					totalAntallProsentFordelt += aProsent[f];
				}
			}
		}

		public function loadImage() {
			var myloader: Loader = new Loader();
			myloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);

			var fileRequest: URLRequest = new URLRequest("bakgrunn.jpg");
			myloader.load(fileRequest);

			function onLoaderReady(e: Event) {
				bakgrunn.addChild(myloader);

				/* Image scaling not working properly, bar at bottom
				var stageAspectRatio:Number = stage.width/stage.height;
				var imageAspectRatio:Number = myloader.width/myloader.height;
				
				if (imageAspectRatio != stageAspectRatio) {
				myloader.height = 1080; 
				myloader.width = myloader.height * imageAspectRatio;
				}*/

				myloader.x = (bakgrunn.width / 2) - (myloader.width / 2);
				myloader.y = (bakgrunn.height / 2) - (myloader.height / 2);

			}
		}

		public function resetAll(): void {

			TweenMax.killTweensOf(contWheel);
			TweenMax.killTweensOf(contNumbers);
			TweenMax.killTweensOf(spins.strip1);
			TweenMax.killTweensOf(spins.strip2);
			TweenMax.killTweensOf(bakgrunnsLoddContainer.bakgrunnsLodd);

			soundChannel.stop();

			if (this.contains(grensesnitt)) {
				removeChild(grensesnitt);
			}

			if (getChildByName("randomLodd") != null) {
				removeChild(randomLodd);
			}

			if (getChildByName("pilen") != null) {
				removeChild(pil);
			}

			myText.txt.visible = false;


			if (bakgrunnsLoddContainer.bakgrunnsLodd.visible) {
				bakgrunnsLoddContainer.bakgrunnsLodd.visible = false;
			}

			while (contNumbers.numChildren > 0) {
				contNumbers.removeChildAt(0);
			}

			for (var i: int = spins.numChildren - 1; i >= 0; i--) {
				spins.getChildAt(i).visible = false;
			}


			if (getChildByName("lodd") != null) {
				removeChild(vinnerlodd);
			}

			if (getChildByName("wheel") != null) {
				removeChild(contWheel);
			}

			contNumbers.x = stage.stageWidth / 2;
			chooser.x = stage.stageWidth / 2;
			//contNumbers.y = stage.stageHeight/2;

			aNumberHolder = new Array();
			chooser.alpha = 0;

		}

		function initPart2() {
			resetAll();
			switch (numberChooser) {
				case 1:
					if (winId > -1) {
						initAndRunNumber(winId)
					};
					break;

				case 2:
					//ettLodd();
					break;

				case 3:
					spinNumbers();
					break;
			}
		}

		// Postcondition: a random int is returned
		public function randomNumber(low: Number = NaN, high: Number = NaN): int {

			if (isNaN(low)) {
				throw new Error("low must be defined");
			}
			if (isNaN(high)) {
				throw new Error("high must be defined");
			}

			return Math.round(Math.random() * (high - low)) + low;
		}

		// Postcondition: tastevalg
		public function reportKeyDown(event: KeyboardEvent): void {

			// trace("keyHandlerfunction: " + event.keyCode);
			if (event.keyCode == Keyboard.ENTER) {
				resetAll();
				initWheel();
			}
			if (event.keyCode == Keyboard.DELETE) {
				resetAll();
			}
			//"3" key
			if (event.keyCode == 51) {
				resetAll();
				loddSirkel();
			}

			//"2" key
			if (event.keyCode == 50) {
				resetAll();
				spinNumbers();
			}
			//"1" key
			if (event.keyCode == 49) {
				resetAll();
				initAndRunNumber(winId);

			}
		}

	}
}