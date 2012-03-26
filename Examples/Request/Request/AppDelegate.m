/**
 * Copyright (C) 2011 Jonathan Diehl
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * 
 * https://github.com/jdiehl/async-network
 */

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize output = _output;
@synthesize input = _input;

// Send the message from the input text field as a request to the ping server
- (IBAction)send:(id)sender;
{
	// read and clear the input
	NSString *message = self.input.stringValue;
	self.input.stringValue = @"";
	
	// display log entry
	[self.output insertText:[NSString stringWithFormat:@">> %@\n", message]];
	
	// send a request to the ping server with the message as body
	[AsyncRequest fireRequestWithHost:AsyncNetworkLocalHost port:kPingServerPort command:0 object:message responseBlock:^(id response, NSError *error) {
		if(error) {
			[self.window presentError:error];
			return;
		}
		[self.output insertText:[NSString stringWithFormat:@"<< %@\n", response]];
	}];
}

@end
