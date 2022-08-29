import { calendar_v3 } from '@googleapis/calendar';
import Schema$Event = calendar_v3.Schema$Event;
import { Event } from './types';

export const reduceEvent = (event: Schema$Event): Event => ({
  title: event.summary ?? '',
  start: new Date(event?.start?.dateTime ?? event?.start?.date ?? ''),
  end: new Date(event?.end?.dateTime ?? event?.end?.date ?? ''),
});

