import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../components";
import { Window } from "../layouts";

export const Microwave = (props, context) => {
  const { act, config, data } = useBackend(context);

  const {
    broken,
    operating,
    dirty,
    items,
  } = data;

  return (
    <Window width={400} height={500} resizable>
      <Window.Content scrollable>
        {broken && (
          <Section>
            <Box color="bad">
              Бббзззттт!!
            </Box>
          </Section>
        ) || operating && (
          <Section>
            <Box color="good">
              Микроволновка работает!<br />
              Подождите...!
            </Box>
          </Section>
        ) || dirty && (
          <Section>
            <Box color="bad">
              Микроволновка грязная!<br />
              Очистите ее перед использованием!
            </Box>
          </Section>
        ) || items.length && (
          <Section level={1} title="Ingredients" buttons={
            <Fragment>
              <Button
                icon="radiation"
                onClick={() => act("cook")}>
                Разогреть
              </Button>
              <Button
                icon="eject"
                onClick={() => act("dispose")}>
                Извлечь
              </Button>
            </Fragment>
          }>
            <LabeledList>
              {items.map(item => (
                <LabeledList.Item key={item.name} label={item.name}>
                  {item.amt} {item.extra}
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        ) || (
          <Section>
            <Box color="bad">
              {config.title} is empty.
            </Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};