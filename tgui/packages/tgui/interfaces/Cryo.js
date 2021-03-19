import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { AnimatedNumber, Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../components";
import { Window } from "../layouts";

const damageTypes = [
  {
    label: "Resp.",
    type: "oxyLoss",
  },
  {
    label: "Токсины",
    type: "toxLoss",
  },
  {
    label: "Brute",
    type: "bruteLoss",
  },
  {
    label: "Burn",
    type: "fireLoss",
  },
];

const statNames = [
  ["good", "В сознании"],
  ["average", "Без сознания"],
  ["bad", "СМЕРТЬ"],
];

export const Cryo = (props, context) => {
  return (
    <Window
      width={520}
      height={470}
      resizeable>
      <Window.Content className="Layout__content--flexColumn">
        <CryoContent />
      </Window.Content>
    </Window>
  );
};

const CryoContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    isOperating,
    hasOccupant,
    occupant = [],
    cellTemperature,
    cellTemperatureStatus,
    isBeakerLoaded,
  } = data;
  return (
    <Fragment>
      <Section
        title="Ячейка"
        flexGrow="1"
        buttons={(
          <Button
            icon="user-slash"
            onClick={() => act('ejectOccupant')}
            disabled={!hasOccupant}>
            Ивлечь
          </Button>
        )}>
        {hasOccupant ? (
          <LabeledList>
            <LabeledList.Item label="Ячейка">
              {occupant.name || "Неизвестно"}
            </LabeledList.Item>
            <LabeledList.Item label="Здоровье">
              <ProgressBar
                min={occupant.health}
                max={occupant.maxHealth}
                value={occupant.health / occupant.maxHealth}
                color={occupant.health > 0 ? 'good' : 'average'}>
                <AnimatedNumber
                  value={Math.round(occupant.health)} />
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="Состояние"
              color={statNames[occupant.stat][0]}>
              {statNames[occupant.stat][1]}
            </LabeledList.Item>
            <LabeledList.Item label="Температура">
              <AnimatedNumber
                value={Math.round(occupant.bodyTemperature)} />
              {' K'}
            </LabeledList.Item>
            <LabeledList.Divider />
            {(damageTypes.map(damageType => (
              <LabeledList.Item
                key={damageType.id}
                label={damageType.label}>
                <ProgressBar
                  value={occupant[damageType.type]/100}
                  ranges={{ bad: [0.01, Infinity] }}>
                  <AnimatedNumber
                    value={Math.round(occupant[damageType.type])} />
                </ProgressBar>
              </LabeledList.Item>
            )))}
          </LabeledList>
        ) : (
          <Flex height="100%" textAlign="center">
            <Flex.Item grow="1" align="center" color="label">
              <Icon
                name="user-slash"
                mb="0.5rem"
                size="5"
              /><br />
              No occupant detected.
            </Flex.Item>
          </Flex>
        )}
      </Section>
      <Section
        title="Питание"
        buttons={(
          <Button
            icon="eject"
            onClick={() => act('ejectBeaker')}
            disabled={!isBeakerLoaded}>
            Извлечь мензурку
          </Button>
        )}>
        <LabeledList>
          <LabeledList.Item label="Питание">
            <Button
              icon="power-off"
              onClick={() => act(isOperating ? 'switchOff' : 'switchOn')}
              selected={isOperating}>
              {isOperating ? "Вкл" : "Выкл"}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Температура" color={cellTemperatureStatus}>
            <AnimatedNumber value={cellTemperature} /> K
          </LabeledList.Item>
          <LabeledList.Item label="Мензурка">
            <CryoBeaker />
          </LabeledList.Item>
        </LabeledList>
      </Section>
    </Fragment>
  );
};

const CryoBeaker = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    isBeakerLoaded,
    beakerLabel,
    beakerVolume,
  } = data;
  if (isBeakerLoaded) {
    return (
      <Fragment>
        {beakerLabel
          ? beakerLabel
          : (
            <Box color="average">
              No label
            </Box>
          )}
        <Box color={!beakerVolume && "bad"}>
          {beakerVolume ? (
            <AnimatedNumber
              value={beakerVolume}
              format={v => Math.round(v) + " units remaining"}
            />
          ) : "Мензурка пуста"}
        </Box>
      </Fragment>
    );
  } else {
    return (
      <Box color="average">
        Мензурка не загружена
      </Box>
    );
  }
};
