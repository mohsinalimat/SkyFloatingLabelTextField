//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit
import XCTest
@testable import SkyFloatingLabelTextField

class SkyFloatingLabelTextFieldTests: XCTestCase {
    
    var floatingLabelTextField: SkyFloatingLabelTextField!
    let customColor = UIColor(red: 125/255, green: 120/255, blue: 50/255, alpha: 1.0)
    let textFieldDelegateMock = TextFieldDelegateMock()
    
    override func setUp() {
        super.setUp()
        floatingLabelTextField = SkyFloatingLabelTextField(frame: CGRectMake(0, 0, 200, 50))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK:  - Colors
    
    func test_whenSettingTextColor_thenTextFieldTextColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.textColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.textColor, self.customColor)
    }
    
    func test_whenSettingPlaceholderColor_thenPlaceholderColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.placeholderColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.placeholderColor, self.customColor)
    }
    
    func test_whenSettingTitleColor_thenTitleLabelTextColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.titleColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingLineColor_thenLineViewBackgroundColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.lineColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingSet_thenTitleLabelTextColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.errorMessage = "test"
        
        // when
        floatingLabelTextField.errorColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingSet_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.errorMessage = "test"
        
        // when
        floatingLabelTextField.errorColor = self.customColor
        
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    func test_whenSettingSelectedTitleColor_withTextfieldBeingSelected_thenTitleLabelTextColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.selectedTitleColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingSelectedLineColor_withTextfieldBeingSelected_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.selectedLineColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    
    // MARK:  - line height
    
    func test_whenInitializingControl_thenLineHeightIsTwoPixelsOnScreen() {
        // given
        let onePixel = 1.0 / Double(UIScreen.mainScreen().scale)
        
        // then
        XCTAssertEqual(Double(floatingLabelTextField.lineHeight), 2.0 * onePixel)
    }
    
    func test_whenSettingLineHeight_thenLineViewHeightIsChangedToThisValue() {
        // when
        floatingLabelTextField.lineHeight = 3
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.size.height, 3)
    }
    
    func test_whenInitializingControl_thenSelectedLineHeightIsFourPixelsOnScreen() {
        // given
        let onePixel = 1.0 / Double(UIScreen.mainScreen().scale)
        
        // then
        XCTAssertEqual(Double(floatingLabelTextField.selectedLineHeight), 4.0 * onePixel)
    }
    
    func test_whenSettingSelectedLineHeight__withTextFieldBeingSelected_thenLineViewHeightIsChangedToThisValue() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.selectedLineHeight = 4
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.size.height, 4)
    }
    
    // MARK:  - text

    func test_hasText_whenTextPropertyIsNotEmpty_thenReturnsTrue() {
        // given
        floatingLabelTextField.text = "hello";
        
        // then
        XCTAssertTrue(floatingLabelTextField.hasText())
    }
    
    func test_hasText_whenTextPropertyIsEmpty_thenReturnsFalse() {
        // given
        floatingLabelTextField.text = "";
        
        // then
        XCTAssertFalse(floatingLabelTextField.hasText())
    }
    
    func test_whenSettingText_withErrorMessagePresent_thenClearsErrorMessage() {
        // given
        floatingLabelTextField.errorMessage = "error"
        floatingLabelTextField.title = "title"
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "ERROR")
        
        // when
        floatingLabelTextField.text = "hello!"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "TITLE")
        XCTAssertNil(floatingLabelTextField.errorMessage)
    }
    
    // MARK:  - highlighted 
    
    func test_whenSettingHighighted_toTrue_withoutAnimation_thenTitleAlphaSetToOne() {
        // given
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        floatingLabelTextField.setHighlighted(true, animated: false)
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingHighighted_toTrue_withAnimation_thenTitleAlphaIsNotChangedImmediately() {
        // given
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        
        // when
        floatingLabelTextField.setHighlighted(true, animated: false)
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingHighighted_toTrue_withAnimation_thenTitleAlphaIsSetToOne_afterOneSecond() {
        // given
        let expectation = self.expectationWithDescription("")
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        
        // when
        floatingLabelTextField.setHighlighted(true, animated: false)
        
        self.delay(1.0, callback: { () -> Void in
            // then
            XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 1.0)
            expectation.fulfill()
        })
        
        self.failOnTimeoutAfterSeconds(5)
    }
    
    func test_whenSettingHighighted_toTrue_withoutAnimation_thenTitleAlphaIsVisible() {
        // given
        XCTAssertFalse(floatingLabelTextField.titleVisible)
        
        // when
        floatingLabelTextField.setHighlighted(true, animated: false)
        
        // then
        XCTAssertTrue(floatingLabelTextField.titleVisible)
    }
    
    func test_whenSettingHighighted_toFalse_then_afterOneSecond_titleIsNotVisible() {
        // given
        let expectation = self.expectationWithDescription("")
        
        // when
        floatingLabelTextField.highlighted = false;
        
        self.delay(1.0, callback: { () -> Void in
            // then
            XCTAssertFalse(self.floatingLabelTextField.titleVisible)
            expectation.fulfill()
        })
        
        self.failOnTimeoutAfterSeconds(5)
    }
    
    // MARK:  - setHighlighted with animation
    
    func test_whenSettingHighlightedToFalse_withoutAnimation_thenTitleAlphaIsZeroImmediately() {
        // given
        floatingLabelTextField.setHighlighted(true, animated: false)
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 1.0)
        
        // when
        floatingLabelTextField.setHighlighted(false, animated: false)
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 0.0)
    }
    
    // MARK:  - selectedTitle
    
    func test_whenTitleAndSelectedTitleAreSet_withControlNotBeingSelected_thenTitleLabelDisplaysUppercaseTitle() {
        // given
        floatingLabelTextField.selected = false
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = "selectedTitle"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "TITLE")
    }
    
    func test_whenTitleIsSetAndSelectedTitleIsNotSet_withControlBeingSelected_thenTitleLabelDisplaysUppercaseTitle() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = nil
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "TITLE")
    }
    
    func test_whenTitleAndSelectedTitleAreSet_withControlBeingSelected_thenTitleLabelDisplaysUppercaseSelectedTitle() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = "selectedTitle"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "SELECTEDTITLE")
    }
    
    // MARK:  - init
    
    func test_whenIntiializingWithCoder_thenTextfieldUIElementsAreCreated() {
        // given
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.finishEncoding()
        let coder = NSKeyedUnarchiver(forReadingWithData: data)
        
        // when
        floatingLabelTextField = SkyFloatingLabelTextField(coder: coder)
        
        // then
        XCTAssertNotNil(floatingLabelTextField.titleLabel)
        XCTAssertNotNil(floatingLabelTextField.lineView)
    }
    
    // MARK: - Responder handling
    
    func test_whenBecomeFirstResponderInvoked_thenTextFieldUserInteractionEnabledSetToTrue() {
        // given
        floatingLabelTextField.userInteractionEnabled = false
        XCTAssertFalse(floatingLabelTextField.userInteractionEnabled)
        
        // when
        floatingLabelTextField.becomeFirstResponder()
        
        // then
        XCTAssertTrue(floatingLabelTextField.userInteractionEnabled)
    }
    
    func test_whenResignFirstResponderInvoked_thenTextFieldUserInteractionEnabledSetToFalse() {
        // given
        floatingLabelTextField.becomeFirstResponder()
        XCTAssertTrue(floatingLabelTextField.userInteractionEnabled)
        
        // when
        floatingLabelTextField.resignFirstResponder()
        
        // then
        XCTAssertFalse(floatingLabelTextField.userInteractionEnabled)
    }
    
    func test_whenTouchesBegan_withNotBeingFirstResponder_thenTextFieldUserInteractionEnabledSetToTrue() {
        // given
        floatingLabelTextField.resignFirstResponder()
        XCTAssertFalse(floatingLabelTextField.userInteractionEnabled)
        
        // when
        floatingLabelTextField.touchesBegan(Set<UITouch>(), withEvent: nil)
        
        // then
        XCTAssertTrue(floatingLabelTextField.userInteractionEnabled)
    }
    
    // MARK: - Textfield delegate methods
    
    // MARK: textFieldShouldBeginEditing
    
    func test_whenTextFieldShouldBeginEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldBeginEditing!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldBeginEditingInvoked)
    }
    
    // MARK: textFieldChanged
    
    func test_whenTextChanged_withNonNilDelegate_thenInvokesTextFieldChangedMethodOnDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.text = "newText"
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldChangedInvoked)
    }
    
    // MARK: textFieldDidBeginEditing
    
    func test_whenTextFieldDidBeginEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.delegate!.textFieldDidBeginEditing!(floatingLabelTextField)
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldDidBeginEditingInvoked)
    }
    
    // MARK: textFieldShouldEndEditing
    
    func test_whenTextFieldShouldEndEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldEndEditing!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldEndEditingInvoked)
    }
    
    // MARK: textFieldDidEndEditing
    
    func test_whenTextFieldDidEndEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.delegate!.textFieldDidEndEditing!(floatingLabelTextField)
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldDidEndEditingInvoked)
    }
    
    // MARK: textFieldShouldReturn
    
    func test_whenTextFieldShouldReturnInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldReturn!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldReturnInvoked)
    }
    
    // MARK: textFieldShouldClear
    
    func test_whenTextFieldShouldClearInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldClear!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldClearInvoked)
    }
    
    // MARK: shouldChangeCharactersInRange
    
    func test_whenShouldChangeCharactersInRangeInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textField!(floatingLabelTextField, shouldChangeCharactersInRange: NSRange(), replacementString:"")
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.shouldChangeCharactersInRangeInvoked)
    }
    
    // MARK:  - control lifecycle events
    
    func test_whenLayoutSubviewsInvoked_thenTitleLabelFrameIsUpdated() {
        // given
        floatingLabelTextField.titleLabel.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertEqual(floatingLabelTextField.titleLabel.frame.height, 0.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.titleLabel.frame.height, 0.0)
    }
    
    func test_whenLayoutSubviewsInvoked_thenFrameIsUpdated() {
        // given
        floatingLabelTextField.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertEqual(floatingLabelTextField.frame.height, 0.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.frame.height, 0.0)
    }
    
    func test_whenLayoutSubviewsInvoked_thenLineViewFrameIsUpdated() {
        // given
        floatingLabelTextField.lineHeight = 2.0
        floatingLabelTextField.lineView.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertNotEqual(floatingLabelTextField.lineView.frame.height, 2.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.height, 2.0)
    }
    
    // MARK: titleHeight()
    
    func test_whenTitleLabelHasFontSet_thenTitleHeightReturnsFontHeight() {
        // given
        let font = UIFont(name: "Arial", size: 16)
        floatingLabelTextField.titleLabel.font = font
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleHeight(), font!.lineHeight)
    }
    
    func test_whenTitleLabelHasFontSetToNil_thenFontSetToDefault() {
        // when
        floatingLabelTextField.titleLabel.font = nil
        
        // then
        XCTAssertNotNil(floatingLabelTextField.titleLabel.font)
    }
    
    // MARK: textHeight()
    
    func test_whenTextFieldHasFontSet_thenTextHeightReturnsFontHeightPlusSeven() {
        // given
        let font = UIFont(name: "Arial", size: 16)
        floatingLabelTextField.font = font
        
        // then
        XCTAssertEqual(floatingLabelTextField.textHeight(), font!.lineHeight + 7)
    }
    
    func test_whenTextFieldHasFontSetToNil_thenFontSetToDefault() {
        // when
        floatingLabelTextField.font = nil
        
        // then
        XCTAssertNotNil(floatingLabelTextField.font)
    }
    
    // MARK: prepareForInterfaceBuilder()
    
    func test_whenPrepareForInterfaceBuilderInvoked_thenSelectedSetToTrue() {
        // given
        XCTAssertFalse(floatingLabelTextField.selected)
        
        // when
        floatingLabelTextField.prepareForInterfaceBuilder()
        
        // then
        XCTAssertTrue(floatingLabelTextField.selected)
    }
    
    // MARK: intrinsicContentSize()
    
    func test_whenIntristicContentSizeInvoked_thenHeightIsTitleHeightAndContentHeightSize() {
        // given
        XCTAssertNotEqual(floatingLabelTextField.titleHeight(), 0)
        XCTAssertNotEqual(floatingLabelTextField.textHeight(), 0)
        
        // when
        let size = floatingLabelTextField.intrinsicContentSize()
        
        // then
        XCTAssertEqual(size.height, floatingLabelTextField.titleHeight() + floatingLabelTextField.textHeight())
    }
    
    // MARK: - Helpers
    
    func failOnTimeoutAfterSeconds(timeout: NSTimeInterval) {
        self.waitForExpectationsWithTimeout(timeout, handler: {(error: NSError?) -> Void in
            if let error = error {
                XCTFail("Call timed out %@", file: error.localizedDescription)
            }
        })
    }
    
    func delay(delay:Double, callback:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), callback)
    }
    
    class TextFieldDelegateMock:NSObject, UITextFieldDelegate {
        var textFieldShouldBeginEditing = false
        var textFieldShouldEndEditing = false
        var textFieldShouldReturn = false
        var textFieldShouldClear = false
        var shouldChangeCharactersInRange = false
        
        var textFieldChangedInvoked = false
        var textFieldShouldBeginEditingInvoked = false
        var textFieldShouldEndEditingInvoked = false
        var textFieldDidBeginEditingInvoked = false
        var textFieldDidEndEditingInvoked = false
        var textFieldShouldReturnInvoked = false
        var textFieldShouldClearInvoked = false
        var shouldChangeCharactersInRangeInvoked = false
        
        func textFieldDidBeginEditing(textField: UITextField) {
            textFieldDidBeginEditingInvoked = true
        }
        
        func textFieldChanged(textField: UITextField) {
            textFieldChangedInvoked = true
        }
        
        func textFieldDidEndEditing(textField: UITextField) {
            textFieldDidEndEditingInvoked = true
        }
        
        func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
            textFieldShouldBeginEditingInvoked = true
            return textFieldShouldBeginEditing
        }
        
        func textFieldShouldEndEditing(textField: UITextField) -> Bool {
            textFieldShouldEndEditingInvoked = true
            return textFieldShouldEndEditing
        }
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textFieldShouldReturnInvoked = true
            return textFieldShouldReturn
        }
        
        func textFieldShouldClear(textField: UITextField) -> Bool {
            textFieldShouldClearInvoked = true
            return textFieldShouldClear
        }
        
        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            shouldChangeCharactersInRangeInvoked = true
            return shouldChangeCharactersInRange
        }
    }
    
    class SkyFloatingLabelTextFieldSpy: NSObject, UITextFieldDelegate {
        var lastSendActionsForControlEventsInvocation: UIControlEvents?
        
        func sendActionsForControlEvents(controlEvents: UIControlEvents) {
            lastSendActionsForControlEventsInvocation = controlEvents
        }
    }
}
