/*
 * Licensed to the Sakai Foundation (SF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The SF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */
package org.sakaiproject.kernel.message;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Will create a message under the user's _private folder. If the box is set
 * to outbox en the pending property to pending or none it will be picked up by
 * the MessagePostProcessor who will then send an OSGi event that feeds it to
 * the correct MessageHandler.
 * 
 * @scr.component metatype="no" immediate="true"
 * @scr.service interface="javax.servlet.Servlet"
 * @scr.property name="sling.servlet.resourceTypes" values="sakai/messagestore"
 * @scr.property name="sling.servlet.methods" value="POST"
 * @scr.property name="sling.servlet.selectors" value="create"
 */
public class CreateMessageServlet extends SlingAllMethodsServlet {

  /**
   *
   */
  private static final long serialVersionUID = 3813877071190736742L;
  private static final Logger LOGGER = LoggerFactory
      .getLogger(CreateMessageServlet.class);

  /**
   * {@inheritDoc}
   * 
   * @see org.sakaiproject.kernel.message.AbstractMessageServlet#handleOperation(org.apache.sling.api.SlingHttpServletRequest,
   *      org.apache.sling.api.servlets.HtmlResponse, java.util.List)
   */
  @Override
  protected void doPost(SlingHttpServletRequest request,
      org.apache.sling.api.SlingHttpServletResponse response)
      throws javax.servlet.ServletException, java.io.IOException {
    LOGGER.info("Creating message.");
    
    MessagingServiceImpl messagingService = new MessagingServiceImpl();
    messagingService.create(request, response);
  }

}
