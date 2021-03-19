import { useBackend } from '../backend';
import { Button, Section } from '../components';
import { Window } from '../layouts';

export const AtmosAlertConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const priorityAlerts = data.priority_alarms || [];
  const minorAlerts = data.minor_alarms || [];
  return (
    <Window
      width={350}
      height={300}
      resizable>
      <Window.Content scrollable>
        <Section title="Тревога">
          <ul>
            {priorityAlerts.length === 0 && (
              <li className="color-good">
                Нет приоритетных предупреждений
              </li>
            )}
            {priorityAlerts.map(alert => (
              <li key={alert.name}>
                <Button
                  icon="times"
                  content={alert.name}
                  color="bad"
                  onClick={() => act('clear', { ref: alert.ref })} />
              </li>
            ))}
            {minorAlerts.length === 0 && (
              <li className="color-good">
                Нет второстепенных предупреждений
              </li>
            )}
            {minorAlerts.map(alert => (
              <li key={alert.name}>
                <Button
                  icon="times"
                  content={alert.name}
                  color="average"
                  onClick={() => act('clear', { ref: alert.ref })} />
              </li>
            ))}
          </ul>
        </Section>
      </Window.Content>
    </Window>
  );
};
