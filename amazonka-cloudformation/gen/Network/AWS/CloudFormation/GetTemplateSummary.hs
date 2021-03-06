{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CloudFormation.GetTemplateSummary
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Returns information about a new or existing template. The
-- 'GetTemplateSummary' action is useful for viewing parameter information,
-- such as default parameter values and parameter types, before you create
-- or update a stack.
--
-- You can use the 'GetTemplateSummary' action when you submit a template,
-- or you can get template information for a running or deleted stack.
--
-- For deleted stacks, 'GetTemplateSummary' returns the template
-- information for up to 90 days after the stack has been deleted. If the
-- template does not exist, a 'ValidationError' is returned.
--
-- /See:/ <http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_GetTemplateSummary.html AWS API Reference> for GetTemplateSummary.
module Network.AWS.CloudFormation.GetTemplateSummary
    (
    -- * Creating a Request
      getTemplateSummary
    , GetTemplateSummary
    -- * Request Lenses
    , gtsTemplateBody
    , gtsTemplateURL
    , gtsStackName

    -- * Destructuring the Response
    , getTemplateSummaryResponse
    , GetTemplateSummaryResponse
    -- * Response Lenses
    , gtsrsVersion
    , gtsrsCapabilitiesReason
    , gtsrsParameters
    , gtsrsMetadata
    , gtsrsDescription
    , gtsrsCapabilities
    , gtsrsResourceTypes
    , gtsrsResponseStatus
    ) where

import           Network.AWS.CloudFormation.Types
import           Network.AWS.CloudFormation.Types.Product
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | The input for the GetTemplateSummary action.
--
-- /See:/ 'getTemplateSummary' smart constructor.
data GetTemplateSummary = GetTemplateSummary'
    { _gtsTemplateBody :: !(Maybe Text)
    , _gtsTemplateURL  :: !(Maybe Text)
    , _gtsStackName    :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'GetTemplateSummary' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'gtsTemplateBody'
--
-- * 'gtsTemplateURL'
--
-- * 'gtsStackName'
getTemplateSummary
    :: GetTemplateSummary
getTemplateSummary =
    GetTemplateSummary'
    { _gtsTemplateBody = Nothing
    , _gtsTemplateURL = Nothing
    , _gtsStackName = Nothing
    }

-- | Structure containing the template body with a minimum length of 1 byte
-- and a maximum length of 51,200 bytes. For more information about
-- templates, see
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html Template Anatomy>
-- in the AWS CloudFormation User Guide.
--
-- Conditional: You must specify only one of the following parameters:
-- 'StackName', 'TemplateBody', or 'TemplateURL'.
gtsTemplateBody :: Lens' GetTemplateSummary (Maybe Text)
gtsTemplateBody = lens _gtsTemplateBody (\ s a -> s{_gtsTemplateBody = a});

-- | Location of file containing the template body. The URL must point to a
-- template (max size: 460,800 bytes) that is located in an Amazon S3
-- bucket. For more information about templates, see
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html Template Anatomy>
-- in the AWS CloudFormation User Guide.
--
-- Conditional: You must specify only one of the following parameters:
-- 'StackName', 'TemplateBody', or 'TemplateURL'.
gtsTemplateURL :: Lens' GetTemplateSummary (Maybe Text)
gtsTemplateURL = lens _gtsTemplateURL (\ s a -> s{_gtsTemplateURL = a});

-- | The name or the stack ID that is associated with the stack, which are
-- not always interchangeable. For running stacks, you can specify either
-- the stack\'s name or its unique stack ID. For deleted stack, you must
-- specify the unique stack ID.
--
-- Conditional: You must specify only one of the following parameters:
-- 'StackName', 'TemplateBody', or 'TemplateURL'.
gtsStackName :: Lens' GetTemplateSummary (Maybe Text)
gtsStackName = lens _gtsStackName (\ s a -> s{_gtsStackName = a});

instance AWSRequest GetTemplateSummary where
        type Rs GetTemplateSummary =
             GetTemplateSummaryResponse
        request = postQuery cloudFormation
        response
          = receiveXMLWrapper "GetTemplateSummaryResult"
              (\ s h x ->
                 GetTemplateSummaryResponse' <$>
                   (x .@? "Version") <*> (x .@? "CapabilitiesReason")
                     <*>
                     (x .@? "Parameters" .!@ mempty >>=
                        may (parseXMLList "member"))
                     <*> (x .@? "Metadata")
                     <*> (x .@? "Description")
                     <*>
                     (x .@? "Capabilities" .!@ mempty >>=
                        may (parseXMLList "member"))
                     <*>
                     (x .@? "ResourceTypes" .!@ mempty >>=
                        may (parseXMLList "member"))
                     <*> (pure (fromEnum s)))

instance ToHeaders GetTemplateSummary where
        toHeaders = const mempty

instance ToPath GetTemplateSummary where
        toPath = const "/"

instance ToQuery GetTemplateSummary where
        toQuery GetTemplateSummary'{..}
          = mconcat
              ["Action" =: ("GetTemplateSummary" :: ByteString),
               "Version" =: ("2010-05-15" :: ByteString),
               "TemplateBody" =: _gtsTemplateBody,
               "TemplateURL" =: _gtsTemplateURL,
               "StackName" =: _gtsStackName]

-- | The output for the GetTemplateSummary action.
--
-- /See:/ 'getTemplateSummaryResponse' smart constructor.
data GetTemplateSummaryResponse = GetTemplateSummaryResponse'
    { _gtsrsVersion            :: !(Maybe Text)
    , _gtsrsCapabilitiesReason :: !(Maybe Text)
    , _gtsrsParameters         :: !(Maybe [ParameterDeclaration])
    , _gtsrsMetadata           :: !(Maybe Text)
    , _gtsrsDescription        :: !(Maybe Text)
    , _gtsrsCapabilities       :: !(Maybe [Capability])
    , _gtsrsResourceTypes      :: !(Maybe [Text])
    , _gtsrsResponseStatus     :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'GetTemplateSummaryResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'gtsrsVersion'
--
-- * 'gtsrsCapabilitiesReason'
--
-- * 'gtsrsParameters'
--
-- * 'gtsrsMetadata'
--
-- * 'gtsrsDescription'
--
-- * 'gtsrsCapabilities'
--
-- * 'gtsrsResourceTypes'
--
-- * 'gtsrsResponseStatus'
getTemplateSummaryResponse
    :: Int -- ^ 'gtsrsResponseStatus'
    -> GetTemplateSummaryResponse
getTemplateSummaryResponse pResponseStatus_ =
    GetTemplateSummaryResponse'
    { _gtsrsVersion = Nothing
    , _gtsrsCapabilitiesReason = Nothing
    , _gtsrsParameters = Nothing
    , _gtsrsMetadata = Nothing
    , _gtsrsDescription = Nothing
    , _gtsrsCapabilities = Nothing
    , _gtsrsResourceTypes = Nothing
    , _gtsrsResponseStatus = pResponseStatus_
    }

-- | The AWS template format version, which identifies the capabilities of
-- the template.
gtsrsVersion :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrsVersion = lens _gtsrsVersion (\ s a -> s{_gtsrsVersion = a});

-- | The list of resources that generated the values in the 'Capabilities'
-- response element.
gtsrsCapabilitiesReason :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrsCapabilitiesReason = lens _gtsrsCapabilitiesReason (\ s a -> s{_gtsrsCapabilitiesReason = a});

-- | A list of parameter declarations that describe various properties for
-- each parameter.
gtsrsParameters :: Lens' GetTemplateSummaryResponse [ParameterDeclaration]
gtsrsParameters = lens _gtsrsParameters (\ s a -> s{_gtsrsParameters = a}) . _Default . _Coerce;

-- | The value that is defined for the 'Metadata' property of the template.
gtsrsMetadata :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrsMetadata = lens _gtsrsMetadata (\ s a -> s{_gtsrsMetadata = a});

-- | The value that is defined in the 'Description' property of the template.
gtsrsDescription :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrsDescription = lens _gtsrsDescription (\ s a -> s{_gtsrsDescription = a});

-- | The capabilities found within the template. Currently, AWS
-- CloudFormation supports only the CAPABILITY_IAM capability. If your
-- template contains IAM resources, you must specify the CAPABILITY_IAM
-- value for this parameter when you use the CreateStack or UpdateStack
-- actions with your template; otherwise, those actions return an
-- InsufficientCapabilities error.
gtsrsCapabilities :: Lens' GetTemplateSummaryResponse [Capability]
gtsrsCapabilities = lens _gtsrsCapabilities (\ s a -> s{_gtsrsCapabilities = a}) . _Default . _Coerce;

-- | A list of all the template resource types that are defined in the
-- template, such as 'AWS::EC2::Instance', 'AWS::Dynamo::Table', and
-- 'Custom::MyCustomInstance'. Use the following syntax to describe
-- template resource types: 'AWS::*' (for all AWS resources), 'Custom::*'
-- (for all custom resources), 'Custom::logical_ID' (for a specific custom
-- resource), 'AWS::service_name::*' (for all resources of a particular AWS
-- service), and 'AWS::service_name::resource_logical_ID' (for a specific
-- AWS resource).
gtsrsResourceTypes :: Lens' GetTemplateSummaryResponse [Text]
gtsrsResourceTypes = lens _gtsrsResourceTypes (\ s a -> s{_gtsrsResourceTypes = a}) . _Default . _Coerce;

-- | The response status code.
gtsrsResponseStatus :: Lens' GetTemplateSummaryResponse Int
gtsrsResponseStatus = lens _gtsrsResponseStatus (\ s a -> s{_gtsrsResponseStatus = a});
