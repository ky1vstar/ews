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
    /// Represents the GetDiscoverySearchConfiguration response.
    /// </summary>
 class GetDiscoverySearchConfigurationResponse extends ServiceResponse
    {
        List<DiscoverySearchConfiguration> configurations = new List<DiscoverySearchConfiguration>();

        /// <summary>
        /// Initializes a new instance of the <see cref="GetDiscoverySearchConfigurationResponse"/> class.
        /// </summary>
        GetDiscoverySearchConfigurationResponse()
            : super()
        {
        }

        /// <summary>
        /// Reads response elements from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
@override
        void ReadElementsFromXml(EwsServiceXmlReader reader)
        {
            this.configurations.Clear();

            base.ReadElementsFromXml(reader);

            reader.ReadStartElement(XmlNamespace.Messages, XmlElementNames.DiscoverySearchConfigurations);
            if (!reader.IsEmptyElement)
            {
                do
                {
                    await reader.Read();
                    if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.DiscoverySearchConfiguration))
                    {
                        this.configurations.Add(DiscoverySearchConfiguration.LoadFromXml(reader));
                    }
                }
                while (!reader.IsEndElement(XmlNamespace.Messages, XmlElementNames.DiscoverySearchConfigurations));
            }
            reader.ReadEndElementIfNecessary(XmlNamespace.Messages, XmlElementNames.DiscoverySearchConfigurations);
        }

        /// <summary>
        /// Searchable mailboxes result
        /// </summary>
 DiscoverySearchConfiguration[] DiscoverySearchConfigurations
        {
            get { return this.configurations.ToArray(); }
        }
    }
