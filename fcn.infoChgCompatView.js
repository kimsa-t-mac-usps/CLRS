function openInfoChgCompatView() {

/*
if (pageParm && pageParm == "FAQ") {

	helpFileName = "FAQ.htm";
	helpFileWindow = "FAQWindow";

}

else {

	if (pageParm && pageParm == "HardCopy") {

		helpFileName = "HowToUse.htm#Hard Copy Version";
		helpFileWindow = "HowToUseWindow";

	}

	else {

		infoChgCompatViewFileName = "ChgCompatView.htm";
		infoChgCompatViewFileWindow = "ChgCompatViewWindow";

	}

}
*/


infoChgCompatViewFileName = "ChgCompatView.htm";
infoChgCompatViewFileWindow = "ChgCompatViewWindow";


newInfoChgCompatViewFileWindow = window.open(infoChgCompatViewFileName, infoChgCompatViewFileWindow, "height=350pt,width=450pt,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");

newInfoChgCompatViewFileWindow.focus();

}


