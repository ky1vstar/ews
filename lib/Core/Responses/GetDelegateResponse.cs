/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */


    /// <summary>
    /// Represents the response to a delegate user retrieval operation.
    /// </summary>
    class GetDelegateResponse extends DelegateManagementResponse
    {
        /* private */ MeetingRequestsDeliveryScope meetingRequestsDeliveryScope = MeetingRequestsDeliveryScope.NoForward;

        /// <summary>
        /// Initializes a new instance of the <see cref="GetDelegateResponse"/> class.
        /// </summary>
        /// <param name="readDelegateUsers">if set to <c>true</c> [read delegate users].</param>
        GetDelegateResponse(bool readDelegateUsers)
            : super(readDelegateUsers, null)
        {
        }

        /// <summary>
        /// Reads response elements from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadElementsFromXml(EwsServiceXmlReader reader)
        {
            base.ReadElementsFromXml(reader);

            if (this.ErrorCode == ServiceError.NoError)
            {
                // If there were no response messages, the reader will already be on the
                // DeliverMeetingRequests start element, so we don't need to read it.
                if (this.DelegateUserResponses.Count > 0)
                {
                    await reader.Read();
                }

                // Make sure that we're at the DeliverMeetingRequests element before trying to read the value.
                // In error cases, the element may not have been returned.
                if (reader.IsStartElement(XmlNamespace.Messages, XmlElementNames.DeliverMeetingRequests))
                {
                    this.meetingRequestsDeliveryScope = reader.ReadElementValue<MeetingRequestsDeliveryScope>();
                }
            }
        }

        /// <summary>
        /// Gets a value indicating if and how meeting requests are delivered to delegates.
        /// </summary>
        MeetingRequestsDeliveryScope MeetingRequestsDeliveryScope
        {
            get { return this.meetingRequestsDeliveryScope; }
        }
    }
