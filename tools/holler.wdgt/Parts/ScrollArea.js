/*
© Copyright 2006-2007 Apple Inc.  All rights reserved.

IMPORTANT:  This Apple software ("Apple Software") is supplied to you in consideration of your agreement to the following terms. Your use, installation and/or redistribution of this Apple Software constitutes acceptance of these terms. If you do not agree with these terms, please do not use, install, or redistribute this Apple Software.

Provided you comply with all of the following terms, Apple grants you a personal, non-exclusive license, under Apple’s copyrights in the Apple Software, to use, reproduce, and redistribute the Apple Software for the sole purpose of creating Dashboard widgets for Mac OS X. If you redistribute the Apple Software, you must retain this entire notice in all such redistributions.

You may not use the name, trademarks, service marks or logos of Apple to endorse or promote products that include the Apple Software without the prior written permission of Apple. Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Apple herein, including but not limited to any patent rights that may be infringed by your products that incorporate the Apple Software or by other works in which the Apple Software may be incorporated.

The Apple Software is provided on an "AS IS" basis.  APPLE MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE APPPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

function CreateScrollArea(scrollAreaID, spec)
{
	var scrollAreaElement = document.getElementById(scrollAreaID);
	
	if (!scrollAreaElement.loaded) {
		var element = null;
		var style = null;
		var contentElement = null;
		var verticalScrollbar = null;
		var horizontalScrollbar = null;
		var hasVerticalScrollbar = spec.hasVerticalScrollbar == undefined ? false : spec.hasVerticalScrollbar;
		var hasHorizontalScrollbar = spec.hasHorizontalScrollbar == undefined ? false : spec.hasHorizontalScrollbar;
		var autoHideScrollbars = spec.autoHideScrollbars == undefined ? false : spec.autoHideScrollbars;
		var leftMargin = spec.leftMargin == undefined ? 0 : spec.leftMargin;
		var rightMargin = spec.rightMargin == undefined ? 0 : spec.rightMargin;
		var topMargin = spec.topMargin == undefined ? 0 : spec.topMargin;
		var bottomMargin = spec.bottomMargin == undefined ? 0 : spec.bottomMargin;
        var scrollbarMargin = spec.scrollbarMargin == undefined ? 0 : spec.scrollbarMargin;;
        var leftScrollbarMargin = leftMargin + scrollbarMargin;
        var rightScrollbarMargin = rightMargin + scrollbarMargin;
		var topScrollbarMargin = topMargin + scrollbarMargin;
		var bottomScrollbarMargin = bottomMargin + scrollbarMargin;
		var spacing = spec.spacing == undefined ? 0 : spec.spacing;
		var scrollbarSize = spec.scrollbarDivSize == undefined ? 0 : spec.scrollbarDivSize;;
		
		// Associate or create the content area element
		if (scrollAreaElement.childNodes.length > 1) {
			contentElement = scrollAreaElement.childNodes[1];
		}
		if (contentElement == null || contentElement == undefined) {
			contentElement = document.createElement("div");
		}
		style = contentElement.style;
		style.position = "absolute";
		style.left = leftMargin + "px";
		style.top = topMargin + "px";
		
		if (hasVerticalScrollbar && hasHorizontalScrollbar) {
			style.right = rightMargin + scrollbarSize + spacing + "px";
			style.bottom = bottomMargin + scrollbarSize + spacing + "px";
		} else if (hasVerticalScrollbar) {
			style.right = rightMargin + scrollbarSize + spacing + "px";
			style.bottom = bottomMargin + "px";
		} else if (hasHorizontalScrollbar) {
			style.right = rightMargin + "px";
			style.bottom = bottomMargin + scrollbarSize + spacing + "px";
		} else {
			style.right = rightMargin + "px";
			style.bottom = bottomMargin + "px";
		}
		scrollAreaElement.appendChild(contentElement);
		scrollAreaElement.contentElement = contentElement;
		scrollAreaElement.content = contentElement;
		
		// Create the vertical scroll bar
		if (hasVerticalScrollbar) {
			element = document.createElement("div");
			element.className = "apple-no-children apple-remove";
			style = element.style;
			style.position = "absolute";
			style.width = scrollbarSize + "px";
			style.height = "auto";
			style.right = rightMargin + "px";
			style.top = topScrollbarMargin + "px";
			style.bottom = hasHorizontalScrollbar ? bottomScrollbarMargin + scrollbarSize + "px" : bottomScrollbarMargin + "px";
			style.appleDashboardRegion = "none";
			scrollAreaElement.appendChild(element);
			verticalScrollbar = new AppleVerticalScrollbar(element);			
			scrollAreaElement.verticalScrollbarElement = element;
		}

		// Create the horizontal scroll bar
		if (hasHorizontalScrollbar) {
			element = document.createElement("div");
			element.className = "apple-no-children apple-remove";
			style = element.style;
			style.position = "absolute";
			style.width = "auto";
			style.height = scrollbarSize + "px";
			style.left = leftScrollbarMargin + "px";
			style.right = hasVerticalScrollbar ? rightScrollbarMargin + scrollbarSize + "px" : rightScrollbarMargin + "px";
			style.bottom = bottomMargin + "px";
			style.appleDashboardRegion = "none";
			scrollAreaElement.appendChild(element);
			horizontalScrollbar = new AppleHorizontalScrollbar(element);
			scrollAreaElement.horizontalScrollbarElement = element;
		}
		
		// Create the scroll area
		if (hasVerticalScrollbar && hasHorizontalScrollbar) {
			scrollAreaElement.object = new AppleScrollArea(contentElement, verticalScrollbar, horizontalScrollbar);
		} else if (hasVerticalScrollbar) {
			scrollAreaElement.object = new AppleScrollArea(contentElement, verticalScrollbar);
		} else if (hasHorizontalScrollbar) {
			scrollAreaElement.object = new AppleScrollArea(contentElement, horizontalScrollbar);
		} else {
			scrollAreaElement.object = new AppleScrollArea(contentElement);
		}

		// Adjust the auto hide setting
		if (verticalScrollbar) {
			verticalScrollbar.setAutohide(autoHideScrollbars);
		}
		if (horizontalScrollbar) {
			horizontalScrollbar.setAutohide(autoHideScrollbars);
		}
		
		scrollAreaElement.object.contentElement = contentElement;
		scrollAreaElement.object.content = contentElement;
		scrollAreaElement.object.refresh();
	}
	
	return scrollAreaElement.object;
}
