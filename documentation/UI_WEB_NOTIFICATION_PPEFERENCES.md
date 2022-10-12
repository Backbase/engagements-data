## General Notifications
This documents builds on our official Community guide, so be sure to read that first. 
[Web journey: Retail notification preferences](https://community.backbase.com/documentation/Retail-Apps-USA/latest/actions_retail_notification_preferences_journey_overview)

### Retail notification preferences
In the Retail notification preferences journey, the bank customer views a list of available accounts and sets up notifications for each account.

#### Configure a web journey
More information on [how to change properties for a journey in code](###-Change-properties-for-a-journey-in-code).

#### Views
This journey has the following views:
- ProductSettingsPageComponent
- ProductNotificationsSettingsComponent

#### Routing
The default routing structure of this journey is the following:

```
export const routes: Route = {
  path: '',
  children: [{
    path: '',
    redirectTo: 'manage-notifications',
    pathMatch: 'full',
  },
  {
    path: 'manage-notifications',
    component: ActionsRetailNotificationPreferencesViewComponent
  },
  {
    path: 'notification-details',
    component: ProductNotificationsSettingsComponent,
    children: [{
      path: '',
      component: ProductSettingsPageComponent
      }],
    },
  ],
}; 
```
### Change properties for a journey in code
To make changes to the default settings of a journey:
Create your config provider. Identify the ActionsRetailNotificationPreferencesJourneyToken you need using the journey’s reference documentation, and import it:

```
import {
  ActionsRetailNotificationPreferencesJourneyToken,
  ActionsRetailNotificationPreferencesJourneyConfiguration
} from '@backbase/actions-retail-notification-preferences-journey-ang';

export const RetailActionsConfigProvider: Provider = {
  provide: ActionsRetailNotificationPreferencesJourneyToken,
  useValue: {
    notificationDismissTime: 5,
    specificationIDs: '1, 4',
    apiMode: 'engagements',
  } as ActionsRetailNotificationPreferencesJourneyConfiguration,
};
```
                     
Inject the config provider in your journey bundle module:

```
import { NgModule } from '@angular/core';
import { ActionsRetailNotificationPreferencesJourneyModule } from '@backbase/actions-retail-notification-preferences-journey-ang';
import { RetailActionsConfigProvider } from '../app/config.providers';
 
@NgModule({
  imports: [ActionsRetailNotificationPreferencesJourneyModule.forRoot()],
  providers: [RetailActionsConfigProvider],
})
export class ActionsRetailNotificationPreferencesJourneyModuleBundleModule {}
```