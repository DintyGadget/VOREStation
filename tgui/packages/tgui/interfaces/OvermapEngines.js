import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section, AnimatedNumber, Collapsible } from "../components";
import { Window } from "../layouts";

export const OvermapEngines = (props, context) => {
  return (
    <Window width={390} height={530}>
      <Window.Content>
        <OvermapEnginesContent />
      </Window.Content>
    </Window>
  );
};

export const OvermapEnginesContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    global_state, // This indicates all engines being powered up or not
    global_limit, // Global Thrust limit
    engines_info, // Array of engines
    total_thrust, // Total thrust of all engines together
  } = data;
  return (
    <Fragment>
      <Section title="Состояние">
        <LabeledList>
          <LabeledList.Item label="Двигатели">
            <Button
              icon="power-off"
              selected={global_state}
              onClick={() => act("global_toggle")}>
              {global_state ? "Отключить все" : "Запустить все"}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Мощность">
            <Button
              onClick={() => act("global_limit", { global_limit: -0.1 })}
              icon="minus" />
            <Button onClick={() => act("set_global_limit")}>
              {global_limit}%
            </Button>
            <Button
              onClick={() => act("global_limit", { global_limit: 0.1 })}
              icon="plus" />
          </LabeledList.Item>
          <LabeledList.Item label="Общая тяга">
            <AnimatedNumber value={total_thrust} />
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Двигатели" height="340px" style={{ "overflow-y": "auto" }}>
        {engines_info.map((engine, i) => (
          <Flex spacing={1} mt={i !== 0 && -1} key={i}>
            <Flex.Item basis="80%">
              <Collapsible title={(
                <Box inline>
                  Двигатель #{i + 1} |
                  Тяга: <AnimatedNumber value={engine.eng_thrust} /> |
                  Лимит: <AnimatedNumber value={engine.eng_thrust_limiter} format={val => val + "%"} />
                </Box>
                // "Engine " + (i + 1)
                //   + " | Thrust: " + engine.eng_thrust
                //   + " | Limit: " + engine.eng_thrust_limiter + "%"
              )}>
                <Section width="127%">
                  <LabeledList>
                    <LabeledList.Item label="Тип">
                      {engine.eng_type}
                    </LabeledList.Item>
                    <LabeledList.Item label="Состояние">
                      <Box color={engine.eng_on ? (engine.eng_on === 1 ? "good" : "average") : "bad"}>
                        {engine.eng_on ? (engine.eng_on === 1 ? "Онлайн" : "Запуск") : "Оффлайн"}
                      </Box>
                      {engine.eng_status.map(status => {
                        if (Array.isArray(status)) {
                          return <Box color={status[1]}>{status[0]}</Box>;
                        } else {
                          return <Box>{status}</Box>;
                        }
                      })}
                    </LabeledList.Item>
                    <LabeledList.Item label="Текущая тяга">
                      {engine.eng_thrust}
                    </LabeledList.Item>
                    <LabeledList.Item label="Мощность">
                      <Button
                        onClick={() => act("limit", { limit: -0.1, engine: engine.eng_reference })}
                        icon="minus" />
                      <Button onClick={() => act("set_limit", { engine: engine.eng_reference })}>
                        {engine.eng_thrust_limiter}%
                      </Button>
                      <Button
                        onClick={() => act("limit", { limit: 0.1, engine: engine.eng_reference })}
                        icon="plus" />
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              </Collapsible>
            </Flex.Item>
            <Flex.Item basis="20%">
              <Button
                fluid
                iconSpin={engine.eng_on === -1}
                color={engine.eng_on === -1 ? "purple" : null}
                selected={engine.eng_on === 1}
                icon="power-off"
                onClick={() => act("toggle_engine", { engine: engine.eng_reference })}>
                {engine.eng_on ? (engine.eng_on === 1 ? "Остановка" : "Зажигание") : "Запуск"}
              </Button>
            </Flex.Item>
          </Flex>
        ))}
      </Section>
    </Fragment>
  );
};