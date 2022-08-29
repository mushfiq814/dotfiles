#!/bin/node
import { auth, calendar, calendar_v3 } from "@googleapis/calendar";
// import type Schema$Event from calendar_v3.Schema$Event;
import { Event } from "./utils/types";
import { reduceEvent } from "./utils/eventReducer";
import "dotenv/config";

const clientIds = process.env.GCAL_CLIENT_ID?.split("&") ?? [];
const clientSecrets = process.env.GCAL_CLIENT_SECRET?.split("&") ?? [];
const refreshTokens = process.env.GCAL_REFRESH_TOKEN?.split("&") ?? [];

const getCalendarClient = (
  clientId: string,
  clientSecret: string,
  refreshToken: string
): calendar_v3.Calendar | undefined => {
  let calClient;
  try {
    const oauth2client = new auth.OAuth2({ clientId, clientSecret });
    oauth2client.setCredentials({ refresh_token: refreshToken });

    calClient = calendar({
      version: "v3",
      auth: oauth2client,
    });
  } catch (e) {
    console.error(e);
  } finally {
    return calClient;
  }
};

const getCalendars = async (
  cal: calendar_v3.Calendar | undefined
): Promise<string[]> => {
  if (!cal) return [];
  const calendars = await cal.calendarList.list();
  return calendars.data?.items?.map((i) => i.id) as string[];
};

const getCalendarEvents = async (
  cal: calendar_v3.Calendar | undefined,
  calendarId: string
): Promise<Event[]> => {
  if (!cal) return [];
  const dt = new Date();
  const ts = {
    min: new Date(dt.setHours(0, 0, 0, 0)),
    max: new Date(dt.setHours(24, 0, 0, 0)),
  };
  const TIME_MIN = ts.min.toISOString();
  const TIME_MAX = ts.max.toISOString();

  const res = await cal.events.list({
    calendarId,
    timeMin: TIME_MIN,
    timeMax: TIME_MAX,
    maxResults: 10,
    singleEvents: true,
    orderBy: "startTime",
  });

  const items = res?.data?.items ?? [];
  return items.map((e: Schema$Event) => reduceEvent(e));
};

// main method
(async () => {
  let eventList: Event[] = [];
  // for each google account
  for (let i = 0; i < clientIds.length; i++) {
    // create cal client
    const cal = getCalendarClient(
      clientIds[i],
      clientSecrets[i],
      refreshTokens[i]
    );
    // get each subscribed calendar
    const calIds = await getCalendars(cal);

    // get events from each calendar
    for (let j = 0; j < calIds.length; j++) {
      const events = await getCalendarEvents(cal, calIds[j]);
      eventList.push(...events);
    }
  }
  console.log(eventList);
})();
