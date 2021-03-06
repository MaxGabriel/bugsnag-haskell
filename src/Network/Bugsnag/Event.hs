{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Network.Bugsnag.Event
    ( BugsnagEvent(..)
    , bugsnagEvent
    ) where

import Data.Aeson
import Data.Aeson.Ext
import Data.List.NonEmpty (NonEmpty)
import Data.Text (Text)
import GHC.Generics
import Network.Bugsnag.App
import Network.Bugsnag.Breadcrumb
import Network.Bugsnag.Device
import Network.Bugsnag.Exception
import Network.Bugsnag.Request
import Network.Bugsnag.Severity
import Network.Bugsnag.Thread
import Network.Bugsnag.User

data BugsnagEvent = BugsnagEvent
    { beExceptions :: NonEmpty BugsnagException
    , beBreadcrumbs :: Maybe [BugsnagBreadcrumb]
    , beRequest :: Maybe BugsnagRequest
    , beThreads :: Maybe [BugsnagThread]
    , beContext :: Maybe Text
    , beGroupingHash :: Maybe Text
    , beUnhandled :: Maybe Bool
    , beSeverity :: Maybe BugsnagSeverity
    , beSeverityReason :: Maybe BugsnagSeverityReason
    , beUser :: Maybe BugsnagUser
    , beApp :: Maybe BugsnagApp
    , beDevice :: Maybe BugsnagDevice
    --, beSession
    -- N.B. omitted because it's an object specific to the Session Tracking API,
    -- and I'm not sure yet how to resolve the naming clash with BugsnagSession.
    , beMetaData :: Maybe Value
    }
    deriving Generic

instance ToJSON BugsnagEvent where
    toJSON = genericToJSON $ bsAesonOptions "be"
    toEncoding = genericToEncoding $ bsAesonOptions "be"

bugsnagEvent :: NonEmpty BugsnagException -> BugsnagEvent
bugsnagEvent exceptions = BugsnagEvent
    { beExceptions = exceptions
    , beBreadcrumbs = Nothing
    , beRequest = Nothing
    , beThreads = Nothing
    , beContext = Nothing
    , beGroupingHash = Nothing
    , beUnhandled = Nothing
    , beSeverity = Nothing
    , beSeverityReason = Nothing
    , beUser = Nothing
    , beApp = Nothing
    , beDevice = Nothing
    , beMetaData = Nothing
    }
