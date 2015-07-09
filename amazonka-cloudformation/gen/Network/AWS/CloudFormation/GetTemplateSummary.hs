{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CloudFormation.GetTemplateSummary
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Returns information about a new or existing template. The
-- @GetTemplateSummary@ action is useful for viewing parameter information,
-- such as default parameter values and parameter types, before you create
-- or update a stack.
--
-- You can use the @GetTemplateSummary@ action when you submit a template,
-- or you can get template information for a running or deleted stack.
--
-- For deleted stacks, @GetTemplateSummary@ returns the template
-- information for up to 90 days after the stack has been deleted. If the
-- template does not exist, a @ValidationError@ is returned.
--
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_GetTemplateSummary.html>
module Network.AWS.CloudFormation.GetTemplateSummary
    (
    -- * Request
      GetTemplateSummary
    -- ** Request constructor
    , getTemplateSummary
    -- ** Request lenses
    , gtsTemplateBody
    , gtsTemplateURL
    , gtsStackName

    -- * Response
    , GetTemplateSummaryResponse
    -- ** Response constructor
    , getTemplateSummaryResponse
    -- ** Response lenses
    , gtsrVersion
    , gtsrParameters
    , gtsrCapabilitiesReason
    , gtsrMetadata
    , gtsrCapabilities
    , gtsrDescription
    , gtsrStatus
    ) where

import           Network.AWS.CloudFormation.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | The input for the GetTemplateSummary action.
--
-- /See:/ 'getTemplateSummary' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gtsTemplateBody'
--
-- * 'gtsTemplateURL'
--
-- * 'gtsStackName'
data GetTemplateSummary = GetTemplateSummary'
    { _gtsTemplateBody :: !(Maybe Text)
    , _gtsTemplateURL  :: !(Maybe Text)
    , _gtsStackName    :: !(Maybe Text)
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetTemplateSummary' smart constructor.
getTemplateSummary :: GetTemplateSummary
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
-- @StackName@, @TemplateBody@, or @TemplateURL@.
gtsTemplateBody :: Lens' GetTemplateSummary (Maybe Text)
gtsTemplateBody = lens _gtsTemplateBody (\ s a -> s{_gtsTemplateBody = a});

-- | Location of file containing the template body. The URL must point to a
-- template (max size: 460,800 bytes) located in an Amazon S3 bucket. For
-- more information about templates, see
-- <http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html Template Anatomy>
-- in the AWS CloudFormation User Guide.
--
-- Conditional: You must specify only one of the following parameters:
-- @StackName@, @TemplateBody@, or @TemplateURL@.
gtsTemplateURL :: Lens' GetTemplateSummary (Maybe Text)
gtsTemplateURL = lens _gtsTemplateURL (\ s a -> s{_gtsTemplateURL = a});

-- | The name or the stack ID that is associated with the stack, which are
-- not always interchangeable. For running stacks, you can specify either
-- the stack\'s name or its unique stack ID. For deleted stack, you must
-- specify the unique stack ID.
--
-- Conditional: You must specify only one of the following parameters:
-- @StackName@, @TemplateBody@, or @TemplateURL@.
gtsStackName :: Lens' GetTemplateSummary (Maybe Text)
gtsStackName = lens _gtsStackName (\ s a -> s{_gtsStackName = a});

instance AWSRequest GetTemplateSummary where
        type Sv GetTemplateSummary = CloudFormation
        type Rs GetTemplateSummary =
             GetTemplateSummaryResponse
        request = post
        response
          = receiveXMLWrapper "GetTemplateSummaryResult"
              (\ s h x ->
                 GetTemplateSummaryResponse' <$>
                   (x .@? "Version") <*>
                     (x .@? "Parameters" .!@ mempty >>=
                        may (parseXMLList "member"))
                     <*> (x .@? "CapabilitiesReason")
                     <*> (x .@? "Metadata")
                     <*>
                     (x .@? "Capabilities" .!@ mempty >>=
                        may (parseXMLList "member"))
                     <*> (x .@? "Description")
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
--
-- The fields accessible through corresponding lenses are:
--
-- * 'gtsrVersion'
--
-- * 'gtsrParameters'
--
-- * 'gtsrCapabilitiesReason'
--
-- * 'gtsrMetadata'
--
-- * 'gtsrCapabilities'
--
-- * 'gtsrDescription'
--
-- * 'gtsrStatus'
data GetTemplateSummaryResponse = GetTemplateSummaryResponse'
    { _gtsrVersion            :: !(Maybe Text)
    , _gtsrParameters         :: !(Maybe [ParameterDeclaration])
    , _gtsrCapabilitiesReason :: !(Maybe Text)
    , _gtsrMetadata           :: !(Maybe Text)
    , _gtsrCapabilities       :: !(Maybe [Capability])
    , _gtsrDescription        :: !(Maybe Text)
    , _gtsrStatus             :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'GetTemplateSummaryResponse' smart constructor.
getTemplateSummaryResponse :: Int -> GetTemplateSummaryResponse
getTemplateSummaryResponse pStatus =
    GetTemplateSummaryResponse'
    { _gtsrVersion = Nothing
    , _gtsrParameters = Nothing
    , _gtsrCapabilitiesReason = Nothing
    , _gtsrMetadata = Nothing
    , _gtsrCapabilities = Nothing
    , _gtsrDescription = Nothing
    , _gtsrStatus = pStatus
    }

-- | The AWS template format version, which identifies the capabilities of
-- the template.
gtsrVersion :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrVersion = lens _gtsrVersion (\ s a -> s{_gtsrVersion = a});

-- | A list of parameter declarations that describe various properties for
-- each parameter.
gtsrParameters :: Lens' GetTemplateSummaryResponse [ParameterDeclaration]
gtsrParameters = lens _gtsrParameters (\ s a -> s{_gtsrParameters = a}) . _Default;

-- | The list of resources that generated the values in the @Capabilities@
-- response element.
gtsrCapabilitiesReason :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrCapabilitiesReason = lens _gtsrCapabilitiesReason (\ s a -> s{_gtsrCapabilitiesReason = a});

-- | The value that is defined for the @Metadata@ property of the template.
gtsrMetadata :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrMetadata = lens _gtsrMetadata (\ s a -> s{_gtsrMetadata = a});

-- | The capabilities found within the template. Currently, AWS
-- CloudFormation supports only the CAPABILITY_IAM capability. If your
-- template contains IAM resources, you must specify the CAPABILITY_IAM
-- value for this parameter when you use the CreateStack or UpdateStack
-- actions with your template; otherwise, those actions return an
-- InsufficientCapabilities error.
gtsrCapabilities :: Lens' GetTemplateSummaryResponse [Capability]
gtsrCapabilities = lens _gtsrCapabilities (\ s a -> s{_gtsrCapabilities = a}) . _Default;

-- | The value that is defined in the @Description@ property of the template.
gtsrDescription :: Lens' GetTemplateSummaryResponse (Maybe Text)
gtsrDescription = lens _gtsrDescription (\ s a -> s{_gtsrDescription = a});

-- | FIXME: Undocumented member.
gtsrStatus :: Lens' GetTemplateSummaryResponse Int
gtsrStatus = lens _gtsrStatus (\ s a -> s{_gtsrStatus = a});
