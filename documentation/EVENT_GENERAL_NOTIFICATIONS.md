## Event General Notifications

This documents builds on our official Community guide, so be sure to read that first. [How to create custom General notifications](https://community.backbase.com/documentation/foundation_services/latest/create_general_notifications)

### Reference General Notifications
Backbase provides the following reference General Notification that can be adopted to your project needs.

| Id | Description | Trigger Event | Channels |
|----|-------------|---------------|----------|
| `account-balance-low` | Notify user when their account balance drops below their specified threshold amount as per their specific notification preference for the account | `com.backbase.dbs.actions.reactive.event.spec.v2.AccountBalanceChangedEvent` | `in-app-notification`, `push` |
| `account-statement-ready` | Notify the user when account statement is ready | `com.backbase.dbs.actions.reactive.event.spec.v2.AccountStatementReadyEvent` | `in-app-notification`, `push` |
| `audit-export-ready` | Notify the user when the Audit Export CSV file they initiated is ready to download | `com.backbase.audit.persistence.event.spec.v1.AuditExportCompletedEvent` | `in-app-notification` |
| `audit-export-failed` | Notify the user when the Audit Export CSV file they initiated has failed | `com.backbase.audit.persistence.event.spec.v1.AuditExportCompletedEvent` | `in-app-notification` |
| `new-message-received` | Notify the user when there is a new message or a reply to their existing conversation | `com.backbase.dbs.messages.pandp.event.spec.v4.MessageReceivedEvent` | `in-app-notification`, `push` |
| `new-transaction-occurred` | Notify the user when a new transaction is posted to their account for which they have enabled their notification preference for the account | `com.backbase.transaction.persistence.event.spec.v1.TransactionsAddedEvent`  | `in-app-notification`, `push` |

### Backbase Events
Below is a list of all the Backbase events that can be used to trigger your custom General Notification.

| Id | Event | Description | Capability | Spec |
|----|-------|-------------|------------|------|
| `account-balance-changed` | `com.backbase.dbs.actions.reactive.event.spec.v2.AccountBalanceChangedEvent` | Account Balance Changed | Core banking system | [AccountBalanceChangedEvent](https://repo.backbase.com/ui/repos/tree/General/backbase-dbs-releases/com/backbase/dbs/actions/actions-reactive-spec/0.2.4) | 
| `account-statement-ready` | `com.backbase.dbs.actions.reactive.event.spec.v2.AccountStatementReadyEvent` | Account Statement Ready | Core banking system | [AccountStatementReadyEvent](https://repo.backbase.com/ui/repos/tree/General/backbase-dbs-releases/com/backbase/dbs/actions/actions-reactive-spec/0.2.4) |
| `audit-export-completed` | `com.backbase.audit.persistence.event.spec.v1.AuditExportCompletedEvent` | Audit Export Completed | Audit | [AuditExportCompletedEvent](https://repo.backbase.com/ui/repos/tree/General/backbase-6-release/com/backbase/dbs/audit/audit-spec/5.0.12) |
| `message-received` | `com.backbase.dbs.messages.pandp.event.spec.v4.MessageReceivedEvent` | Message Received | Messages | [MessageReceivedEvent](https://repo.backbase.com/ui/repos/tree/General/backbase-dbs-releases/com/backbase/dbs/messages/messages-service/1.1.236/messages-service-1.1.236-events.zip) |
| `transaction-added` | `com.backbase.transaction.persistence.event.spec.v1.TransactionsAddedEvent` | Transaction Added | Transaction | [TransactionsAddedEvent](https://repo.backbase.com/ui/repos/tree/General/backbase-dbs-releases/com/backbase/dbs/transaction/transaction-persistence-messaging-api/1.94) |

### Notification Route
Below is a list of routes that can be used by your notification.

| Id  | Description | Route data | Channel |
|-----|-------------|------------|---------|
| `arrangement-view` | Route to the arrangement view with specific arrangement from `arrangementId` field of the Route data | `{\"id\":\"{{event.id}}\",\"arrangementId\":\"{{event.arrangementId}}\"}` | `in-app-notification`, `push` |
| `audit-download-view` | Route to the specific link with the audit export report. Link should be provided in the Route data | `{\"link\":\"{{{event.link}}}\"}` | `in-app-notification` |
| `conversation-view` | Route to the specific conversation with `conversationId` from the Route data | `{\"id\":\"{{event.conversationId}}\"}` | `in-app-notification`, `push` |
| `transaction-view` | Route to the transaction view with specific transaction and arrangement. These fields should be specified field in the Route data | `{\"id\":\"{{event.id}}\",\"arrangementId\":\"{{event.arrangementId}}\"}` | `in-app-notification`, `push` |

### Engagement Channels
The Engagements capability uses the channels from the Message Delivery capability here are a list of the supported channels.

| Id  | Description | Spec |
|-----|-------------|------|
| `in-app-notification` | Short in-app web message [Notification service](https://community.backbase.com/documentation/DBS/latest/notifications) | [Notification channel event](https://repo.backbase.com/ui/repos/tree/General/backbase-6-release/com/backbase/communication/communication/2.0.0-b17/communication-2.0.0-b17-events.zip) |
| `push` | Mobile push notification sent directly to a user’s mobile device | [Push channel event](https://repo.backbase.com/ui/repos/tree/General/backbase-6-release/com/backbase/communication/communication/2.0.0-b17/communication-2.0.0-b17-events.zip) |
| `sms` | Sms notification sent directly to a user’s mobile phone | [Sms channel event](https://repo.backbase.com/ui/repos/tree/General/backbase-6-release/com/backbase/communication/communication/2.0.0-b17/communication-2.0.0-b17-events.zip) |
| `email` | Email notification sent to the user's email address | [Email channel event](https://repo.backbase.com/ui/repos/tree/General/backbase-6-release/com/backbase/communication/communication/2.0.0-b17/communication-2.0.0-b17-events.zip) |