import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../components";
import { Window } from "../layouts";

export const OvermapShipSensors = (props, context) => {
  return (
    <Window width={375} height={545} resizable>
      <Window.Content>
        <OvermapShipSensorsContent />
      </Window.Content>
    </Window>
  );
};

export const OvermapShipSensorsContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    viewing,
    on,
    range,
    health,
    max_health,
    heat,
    critical_heat,
    status,
    contacts,
  } = data;

  return (
    <Fragment>
      <Section title="Состояние" buttons={(
        <Fragment>
          <Button
            icon="eye"
            selected={viewing}
            onClick={() => act("viewing")}>
            Смотреть карту
          </Button>
          <Button
            icon="power-off"
            selected={on}
            onClick={() => act("toggle_sensor")}>
            {on ? "Сенсоры вкл" : "Сенсоры выкл"}
          </Button>
        </Fragment>
      )}>
        <LabeledList>
          <LabeledList.Item label="Состояние">
            {status}
          </LabeledList.Item>
          <LabeledList.Item label="Диапазон">
            <Button
              icon="signal"
              onClick={() => act("range")}>
              {range}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Целостность">
            <ProgressBar
              ranges={{
                good: [max_health * 0.75, Infinity],
                average: [max_health * 0.25, max_health * 0.75],
                bad: [-Infinity, max_health * 0.25],
              }}
              value={health}
              maxValue={max_health}>
              {health} / {max_health}
            </ProgressBar>
          </LabeledList.Item>
          <LabeledList.Item label="Температура">
            <ProgressBar
              ranges={{
                bad: [critical_heat * 0.75, Infinity],
                average: [critical_heat * 0.5, critical_heat * 0.75],
                good: [-Infinity, critical_heat * 0.5],
              }}
              value={heat}
              maxValue={critical_heat}>
              {heat < critical_heat * 0.5 && (
                <Box>Температура низкая.</Box>
              ) || heat < critical_heat * 0.75 && (
                <Box>Температура сенсоров высокая!</Box>
              ) || (
                <Box>КРИТИЧЕСКАЯ ТЕМПЕРАТУРА: немедленно уменьшите мощность!</Box>
              )}
            </ProgressBar>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Связь">
        {contacts.length && contacts.map(alien => (
          <Button
            key={alien.ref}
            fluid
            icon="search"
            onClick={() => act("scan", { scan: alien.ref })}>
            <Box bold inline>Scan: {alien.name}</Box>
            <Box inline>, bearing: {alien.bearing}&deg;</Box>
          </Button>
        )) || (
          <Box color="average">
            No contacts on sensors.
          </Box>
        )}
      </Section>
      {data.status === "MISSING" && (
        <Section title="Ошибка">
          <Button
            icon="wifi"
            onClick={() => act("link")}>
            Подключиться к комплекту датчиков?
          </Button>
        </Section>
      ) || null}
    </Fragment>
  );
};